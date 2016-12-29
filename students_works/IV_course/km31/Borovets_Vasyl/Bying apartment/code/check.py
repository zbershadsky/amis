import re

def chek_name (name):
     if re.match(r'^[A-Z]{1}[a-z]{1,15}-{0,1}[A-Z]{0,1}[a-z]{0,15}[\s]{1}[A-Z]{1}[a-z]{1,15}$', name):
         return True
     else:
         return False

def chek_email(name):
    if re.match(r'^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$', name):
        return True
    else:
        return False

def chek_password (name):
    return re.match(r'^.{6,}$', name)

def chek_login(name):
    if re.match(r'^[A-Za-z]{1,}[A-Za-z0-9_]{1,15}$', name):
        return True
    else:
        return False
def chek_city(city):
    if re.match(r'^[A-Za-z\-\s]{1,}$', city):
        return True
    else:
        return False
def chek_price(min,max):
    try:
        min=float(min)
        max=float(max)
        if (min<max):
            return True
        return False
    except:
        return False

def check_title(name):
    if re.match(r'^[A-Za-z0-9\s]{5,35}$', name):
        return True
    else:
        return False

def chek_input_price(name):
    try:
        int(name)
        return True
    except:
        return False

def check_cadastr(name):

        if re.match(r'^[0-9]{6}[:]{1}[0-9]{2}[:]{1}[0-9]{3}[:]{1}[0-9]{1}$', name):
            return True
        else:
            return False

def chek_street(name):
    if re.match(r'^[A-Za-z\-\s]{1,}$', name):
        return True
    else:
        return False

def check_home(name):
    if re.match(r'^[1-9]{1}[A-Z0-9]{0,4}$', name):
        return True
    else:
        return False

def check_flat(name):
    if re.match(r'^[1-9]{1}[A-Z0-9]{0,4}$', name):
        return True
    else:
        return False


