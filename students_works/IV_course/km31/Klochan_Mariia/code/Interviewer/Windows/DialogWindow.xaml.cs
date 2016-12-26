using Interviewer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data.Entity;
using System.Collections.ObjectModel;

namespace Interviewer.Windows
{
    /// <summary>
    /// Interaction logic for DialogWindow.xaml
    /// </summary>
    public partial class DialogWindow : Window
    {
        public static readonly DependencyProperty ModeProperty =
            DependencyProperty.Register("Mode", typeof(InterviewMode), typeof(DialogWindow));

        // .NET Property wrapper
        public InterviewMode Mode
        {
            get { return (InterviewMode)GetValue(ModeProperty); }
            set { SetValue(ModeProperty, value); }
        }

        public Interview Interview { get; protected set; }
        public ObservableCollection<User> Users { get; protected set; }
        public User CurrentUser { get; protected set; }

        const int MaxUsersCount = 5;

        private bool _isSaved = false;

        public DialogWindow(Interview interview, User currentUser)
        {
            CurrentUser = currentUser;
            Users = new ObservableCollection<User>();
            using (var ctx = new InterviewerContext())
            {
                Users.AddRange(ctx.Users);
                Interview = ctx.Interviews.Include(i => i.Lines).Include(i => i.Asker).Include(i => i.Respondent).SingleOrDefault(i => i.Id == interview.Id);
                if (Interview == null)
                    Interview = interview;
                else
                {               
                    // Order the lines next
                    var lines = Interview.Lines.ToList();
                    Interview.Lines.Clear();
                    Interview.Lines.AddRange(lines.OrderBy(l => l.Number));
                }
            }
            DataContext = this;
            InitializeComponent();
            // Bind listview to users, apply filter and max count
            usersListView.ItemsSource = Users.Where(u => userSearchPredicate(u)).Take(MaxUsersCount);
            Mode = InterviewMode.Reading;
            switch (Interview.Status)
            {
                case InterviewStatus.Creating:
                    Mode = InterviewMode.Creating;
                    break;
                case InterviewStatus.Active:
                    if (Interview.Respondent.Username == currentUser.Username)
                        Mode = InterviewMode.Replying;
                    break;
                case InterviewStatus.Finished:
                    if (currentUser.IsEditor)
                        Mode = InterviewMode.Editing;
                    break;
                case InterviewStatus.Published:
                    break;
                default:
                    break;
            }
        }

        private void SaveInterview()
        {
            using (var ctx = new InterviewerContext())
            {
                ctx.InterviewLines.RemoveRange(ctx.InterviewLines.Where(l => l.InterviewId == Interview.Id));
                var lines = Interview.Lines.ToList();
                int i = 1;
                foreach (var item in lines)
                {
                    item.Number = i++;
                    item.Interview = null;
                    ctx.Entry(item).State = EntityState.Added;
                }
                Interview.RespondentUsername = Interview.Respondent?.Username;
                Interview.AskerUsername = Interview.Asker?.Username;
                Interview.Asker = null;
                Interview.Respondent = null;
                if (Interview.Id == -1)
                    ctx.Entry(Interview).State = EntityState.Added;
                else
                    ctx.Entry(Interview).State = EntityState.Modified;
                ctx.SaveChanges();
            }
        }

        private bool ValidateInterview()
        {
            if (Interview.Respondent == null)
            {
                MessageBox.Show("Respondent could not be empty.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(Interview.Title))
            {
                MessageBox.Show("Title could not be empty.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(Interview.Preview))
            {
                MessageBox.Show("Preview could not be empty.");
                return false;
            }
            if (Interview.Lines.Count == 0)
            {
                MessageBox.Show("Interview should have at least one question.");
                return false;
            }
            return true;
        }

        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                switch (Mode)
                {
                    case InterviewMode.Reading:
                        break;
                    case InterviewMode.Creating:
                        if (!ValidateInterview())
                            return;
                        Interview.Status = InterviewStatus.Active;
                        SaveInterview();
                        break;
                    case InterviewMode.Replying:
                        Interview.Status = InterviewStatus.Finished;
                        SaveInterview();
                        break;
                    case InterviewMode.Editing:
                        if (!ValidateInterview())
                            return;
                        Interview.Status = InterviewStatus.Published;
                        SaveInterview();
                        break;
                    default:
                        break;
                }
                _isSaved = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void AddQuestion_Click(object sender, RoutedEventArgs e)
        {
            Interview.Lines.Add(new InterviewLine() { Interview = Interview, InterviewId = Interview.Id, Number = -1 });
        }

        private void DeleteQuestion_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var line = (sender as Button)?.Tag as InterviewLine;
                if (line != null)
                    Interview.Lines.Remove(line);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Could not delete question");
            }
        }
        
        private void userSearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            CollectionViewSource.GetDefaultView(usersListView.ItemsSource).Refresh();
        }
        
        private bool userSearchPredicate(User user)
        {
            var txt = userSearchTextBox.Text?.Trim()?.ToLower();
            if (user?.Username == Interview.Asker?.Username)
                return false;
            if (!user.IsRespondent)
                return false;
            if (string.IsNullOrEmpty(txt) || user == null)
                return true;
            return user.Username.ToLower().Contains(txt)
                || (user.FirstName?.ToLower()?.Contains(txt) ?? false)
                || (user.LastName?.ToLower()?.Contains(txt) ?? false);
        }

        private void UserList_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var user = (sender as Button)?.Tag as User;
                if (user == null)
                    return;
                Interview.Respondent = user;
                dropDownUsers.Visibility = Visibility.Collapsed;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Could not set the respondent");
            }
        }

        private void RespondentButton_Click(object sender, RoutedEventArgs e)
        {
            if (Mode == InterviewMode.Creating)
            {
                if (dropDownUsers.Visibility == Visibility.Visible)
                    dropDownUsers.Visibility = Visibility.Collapsed;
                else
                    dropDownUsers.Visibility = Visibility.Visible;
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                if (!_isSaved && Mode != InterviewMode.Reading)
                {
                    var dres = MessageBox.Show("Do you want to save your interview?", "Inerview not saved", MessageBoxButton.YesNoCancel);
                    if (dres == MessageBoxResult.Yes)
                        SaveInterview();
                    else if (dres == MessageBoxResult.Cancel)
                        e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }
    }

    public enum InterviewMode { Reading, Creating, Replying, Editing }
}
