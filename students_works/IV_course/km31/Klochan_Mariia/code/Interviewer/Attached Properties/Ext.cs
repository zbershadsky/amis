using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Interviewer
{
    public static class Ext
    {
        public static readonly DependencyProperty PlaceholderProperty = DependencyProperty.RegisterAttached(
            "Placeholder", typeof(string), typeof(Ext), new PropertyMetadata(""));

        public static void SetPlaceholder(DependencyObject element, string value)
        {
            element.SetValue(PlaceholderProperty, value);
        }

        public static string GetPlaceholder(DependencyObject element)
        {
            return (string)element.GetValue(PlaceholderProperty);
        }



        public static readonly DependencyProperty IsValidProperty = DependencyProperty.RegisterAttached(
            "IsValid", typeof(bool), typeof(Ext), new PropertyMetadata(true));

        public static void SetIsValid(DependencyObject element, bool value)
        {
            element.SetValue(IsValidProperty, value);
        }

        public static bool GetIsValid(DependencyObject element)
        {
            return (bool)element.GetValue(IsValidProperty);
        }
    }
}
