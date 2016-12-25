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

namespace Interviewer.Windows
{
    /// <summary>
    /// Interaction logic for SignUpWindow.xaml
    /// </summary>
    public partial class SignUpWindow : Window
    {
        public static readonly DependencyProperty UserProperty =
            DependencyProperty.Register("User", typeof(User), typeof(SignUpWindow));

        public User User
        {
            get { return (User)GetValue(UserProperty); }
            set { SetValue(UserProperty, value); }
        }

        public static readonly DependencyProperty ModeProperty =
            DependencyProperty.Register("Mode", typeof(SignUpMode), typeof(SignUpWindow));

        public SignUpMode Mode
        {
            get { return (SignUpMode)GetValue(ModeProperty); }
            set { SetValue(ModeProperty, value); }
        }

        public string OldPassword { get; set; }

        public SignUpWindow() : this(new User(), SignUpMode.Login)
        { }

        public SignUpWindow(User user, SignUpMode mode)
        {
            User = user;
            Mode = mode;
            if (Mode == SignUpMode.Modify)
                User.Password = "";
            DataContext = this;
            InitializeComponent();
        }

        private void buttonSignIn_Click(object sender, RoutedEventArgs e)
        {
            Mode = SignUpMode.Login;
        }

        private void buttonSignUp_Click(object sender, RoutedEventArgs e)
        {
            Mode = SignUpMode.Register;
        }

        private void SignIn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                User user = null;
                using (var ctx = new InterviewerContext())
                {
                    user = ctx.Users.Where(u => u.Username == User.Username && u.Password == User.Password).SingleOrDefault();
                }
                if (user == null)
                {
                    MessageBox.Show("User not found.");
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                return;
            }
            OpenMainWindow();
        }

        private void SignUp_Click(object sender, RoutedEventArgs e)
        {
            try
            { 
                using (var ctx = new InterviewerContext())
                {
                    if (ctx.Users.Where(u => u.Username == User.Username).FirstOrDefault() != null)
                    {
                        MessageBox.Show("User with such username already exists.");
                        return;
                    }
                    ctx.Users.Add(User);
                    ctx.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                return;
            }
            OpenMainWindow();
        }

        private void OpenMainWindow()
        {
            this.Hide();
            var mw = new MainWindow(User);
            mw.Closed += (o, e2) => this.Close();
            mw.Show();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (var ctx = new InterviewerContext())
                {
                    if (ctx.Users.Where(u => u.Username == User.Username && u.Password == OldPassword).Count() == 0)
                    {
                        MessageBox.Show("Old password is wrong.");
                        return;
                    }
                    ctx.Entry(User).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                return;
            }
            Close();
        }
    }

    public enum SignUpMode { Login, Register, Modify, View }
}
