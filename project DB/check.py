import re

def check_email(Email):
    pattern = '^[-\w.]+@([A-z0-9][-A-z0-9]+\.)+[A-z]{2,4}$'
    if re.match(pattern,Email):
        return True
    else:
        return False

def check_password(Password):
    pattern = '(?=^.{8,16}$)((?=.*\d)|(?=.*\w+))'
    if re.match(pattern,Password):
        return True
    else:
        return False

def check_Name(Name):
    pattern = '[A-Z][a-zA-Z]+((\-)+([A-Z][a-zA-Z]+))?$'
    if re.match(pattern,Name):
        return True
    else:
        return False

def check_Surname(Surname):
    pattern = '[A-Z][a-zA-Z]+((\-)+([A-Z][a-zA-Z]+))?$'
    if re.match(pattern,Surname):
        return True
    else:
        return False

def check_Phone(Phone):
    pattern = '[0-9]{9,10}$'
    if re.match(pattern,Phone):
        return True
    else:
        return False

def check_Title(Title):
    pattern = '[A-Z0-9][a-zA-Z0-9\ \,\:\.]+'
    if re.match(pattern,Title):
        return True
    else:
        return False

def check_Theme(Theme):
    pattern = '[A-Z][a-zA-Z0-9\ ]+'
    if re.match(pattern,Theme):
        return True
    else:
        return False

def check_Price(Price):
    pattern = '([0-9]+\.+[0-9][0-9])|([1-9][0-9]+)'
    if re.match(pattern,Price):
        return True
    else:
        return False

def check_Place_Quantity(Quantity):
    pattern = '[1-9][0-9]*'
    if re.match(pattern,Quantity):
        return True
    else:
        return False

def check_Time(Time):
    pattern = '([2][0-3]\:[0-5][0-9])|([0-1][0-9]\:[0-5][0-9])'
    if re.match(pattern,Time):
        return True
    else:
        return False
