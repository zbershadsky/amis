using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace Interviewer.Converters
{
    class TextValidationConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string text = value as string;
            TextValidationSettings s = (TextValidationSettings)parameter ?? new TextValidationSettings();
            if (!s.NotEmpty && string.IsNullOrEmpty(text)) return true;
            return text != null && text.Length >= s.MinLength && text.Length < s.MaxLength;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return null;
        }
    }

    class TextValidationSettings
    {
        public bool NotEmpty { get; set; }
        public int MinLength { get; set; }
        public int MaxLength { get; set; }
        public TextValidationSettings()
        {
            NotEmpty = false;
            MinLength = 1;
            MaxLength = 30;
        }
    }
}
