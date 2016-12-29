using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interviewer.Models
{
    public class InterviewLine : BaseNotifyPropertyChanged
    {
        private int _Number;
        [Key, Column(Order = 0)]
        public int Number
        {
            get { return _Number; }
            set
            {
                _Number = value;
                OnPropertyChanged("Number");
            }
        }

        [Key, Column(Order = 1)]
        public int InterviewId { get; set; }

        private Interview _Interview;
        [ForeignKey("InterviewId")]
        public Interview Interview
        {
            get { return _Interview; }
            set
            {
                _Interview = value;
                OnPropertyChanged("Interview");
            }
        }

        private string _Question;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(2000)]
        public string Question
        {
            get { return _Question; }
            set
            {
                _Question = value;
                OnPropertyChanged("Question");
            }
        }

        private string _Reply;
        [Column(TypeName = "NVARCHAR2")]
        [MaxLength(2000)]
        public string Reply
        {
            get { return _Reply; }
            set
            {
                _Reply = value;
                OnPropertyChanged("Reply");
            }
        }
    }
}
