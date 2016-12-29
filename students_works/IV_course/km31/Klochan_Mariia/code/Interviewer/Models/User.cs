using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Interviewer.Models
{
    public class User : BaseNotifyPropertyChanged
    {
        private string _Username;
        [Key]
        public string Username
        {
            get { return _Username; }
            set
            {
                _Username = value;
                OnPropertyChanged("Username");
            }
        }

        private string _FirstName;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(40)]
        public string FirstName
        {
            get { return _FirstName; }
            set
            {
                _FirstName = value;
                OnPropertyChanged("FirstName");
            }
        }


        private string _LastName;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(40)]
        public string LastName
        {
            get { return _LastName; }
            set
            {
                _LastName = value;
                OnPropertyChanged("LastName");
            }
        }

        private string _Email;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(40)]
        public string Email
        {
            get { return _Email; }
            set
            {
                _Email = value;
                OnPropertyChanged("Email");
            }
        }

        private string _Password;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(40)]
        public string Password
        {
            get { return _Password; }
            set
            {
                _Password = value;
                OnPropertyChanged("Password");
            }
        }
        
        private bool _IsAsker;
        public bool IsAsker
        {
            get { return _IsAsker; }
            set
            {
                _IsAsker = value;
                OnPropertyChanged("IsAsker");
            }
        }

        private bool _IsRespondent;
        public bool IsRespondent
        {
            get { return _IsRespondent; }
            set
            {
                _IsRespondent = value;
                OnPropertyChanged("IsRespondent");
            }
        }

        private bool _IsEditor;
        public bool IsEditor
        {
            get { return _IsEditor; }
            set
            {
                _IsEditor = value;
                OnPropertyChanged("IsEditor");
            }
        }
    }
}
