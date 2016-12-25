using Interviewer.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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

namespace Interviewer.Windows
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public User User { get; protected set; }

        public ObservableCollection<Interview> Interviews { get; protected set; }

        public MainWindow(User user)
        {
            using (var ctx = new InterviewerContext())
                User = ctx.Users.Where(u => u.Username == user.Username).SingleOrDefault();
            if (User == null)
            {
                MessageBox.Show(string.Format("Can not find user with username '{0}' in database. This should not normally happen.", user.Username));
                Close();
            }
            Interviews = new ObservableCollection<Interview>();
            FillInterviews();
            DataContext = this;
            InitializeComponent();
        }

        private void MyAccount_Click(object sender, RoutedEventArgs e)
        {
            new SignUpWindow(User, SignUpMode.Modify).ShowDialog();
        }

        private void CreateNewInterview_Click(object sender, RoutedEventArgs e)
        {
            var i = new Interview()
            {
                Id = -1,
                Asker = User,
                AskerUsername = User.Username,
                Status = InterviewStatus.Creating
            };
            OpenInterviewWindow(i);
        }

        private void InterviewTitle_Clicked(object sender, RoutedEventArgs e)
        {
            var i = (e.Source as Control)?.Tag as Interview;
            if (i != null)
                OpenInterviewWindow(i);
        }

        private void OpenInterviewWindow(Interview interview)
        {
            new DialogWindow(interview, User).ShowDialog();
            FillInterviews();
        }

        private void showMyInterviewsCheckBox_Click(object sender, RoutedEventArgs e)
        {
            FillInterviews();
        }

        private void FillInterviews()
        {
            bool showMine = showMyInterviewsCheckBox != null && showMyInterviewsCheckBox.IsChecked.HasValue && showMyInterviewsCheckBox.IsChecked.Value;
            Interviews.Clear();
            using (var ctx = new InterviewerContext())
                foreach (var i in showMine
                    ? ctx.Interviews.Where(i => i.Asker.Username == User.Username || i.Respondent.Username == User.Username || (User.IsEditor && i.Status == InterviewStatus.Finished))
                    : ctx.Interviews.Where(i => i.Status == InterviewStatus.Published))
                    Interviews.Add(i);
        }

        private void Update_Click(object sender, RoutedEventArgs e)
        {
            FillInterviews();
        }
    }
}
