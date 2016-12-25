using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interviewer.Models
{
    public class Interview : BaseNotifyPropertyChanged
    {
        private int _Id;
        public int Id
        {
            get { return _Id; }
            set
            {
                _Id = value;
                OnPropertyChanged("Id");
            }
        }

        private string _AskerUsername;
        public string AskerUsername
        {
            get { return _AskerUsername; }
            set
            {
                _AskerUsername = value;
                OnPropertyChanged("AskerUsername");
            }
        }

        private User _Asker;
        [ForeignKey("AskerUsername")]
        public User Asker
        {
            get { return _Asker; }
            set
            {
                _Asker = value;
                OnPropertyChanged("Asker");
            }
        }

        private string _RespondentUsername;
        public string RespondentUsername
        {
            get { return _RespondentUsername; }
            set
            {
                _RespondentUsername = value;
                OnPropertyChanged("RespondentUsername");
            }
        }

        private User _Respondent;
        [ForeignKey("RespondentUsername")]
        public User Respondent
        {
            get { return _Respondent; }
            set
            {
                _Respondent = value;
                OnPropertyChanged("Respondent");
            }
        }

        private InterviewStatus _Status;
        public InterviewStatus Status
        {
            get { return _Status; }
            set
            {
                _Status = value;
                OnPropertyChanged("Status");
            }
        }
        
        public ObservableCollection<InterviewLine> _Lines;
        public ObservableCollection<InterviewLine> Lines
        {
            get
            {
                if (_Lines == null)
                    _Lines = new ObservableCollection<InterviewLine>();
                return _Lines;
            }
            protected set
            {
                _Lines = value;
                OnPropertyChanged("Lines");
            }
        }
    
    
        private string _Title;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(2000)]
        public string Title
        {
            get { return _Title; }
            set
            {
                _Title = value;
                OnPropertyChanged("Title");
            }
        }

        private string _Preview;
        [Column(TypeName = "NVARCHAR2")]
        [StringLength(2000)]
        public string Preview
        {
            get { return _Preview; }
            set
            {
                _Preview = value;
                OnPropertyChanged("Preview");
            }
        }
    }

    public enum InterviewStatus { Creating, Active, Finished, Published }
}
