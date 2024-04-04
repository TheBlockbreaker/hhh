
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Log in</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href='//media.jumpstart.com/JSWeb/CssLib/JSA/bootstrap4.1.1.min.css'>
<link rel="stylesheet" href='//media.jumpstart.com/JSWeb/CssLib/JSA/jsam-login.css'>
<script type='text/javascript' src='//media.jumpstart.com/JSWeb/JScript/jquery/jquery-1.9.1.min.js'></script>
<script type='text/javascript' src='//media.jumpstart.com/JSWeb/CssLib/JSA/js/bootstrap.min.js' ></script>
</head>

<body>
	<div class="jsa-school-logo"></div>	
	<div class="jsa-school-form">
        <div id="form-login">
		    <h2>Login with</h2>
            <div class="alt-button-wrapper">
                <button class="alt-button" onclick="ToggleMicrosoftButtons()">
                    <div class="microsoft-icon"></div>                
                    <span class="alt-button-text">Microsoft</span>               
                </button>
                <button class="alt-button" onclick="RedirectToCleverLogin()">
                    <div class="clever-icon"></div>
                    <span class="alt-button-text">Clever</span></button>
                <button class="alt-button" onclick="RedirectToGoogleLogin()">
                    <div class="google-icon"></div>
                    <span class="alt-button-text">Google</span></button>
            </div>
            <div id="microsoft-buttons-wrapper" style="display: none;">
			    <button class="microsoft-button" onclick="RedirectToMicrosoftLogin(false)">Student</button>
			    <button class="microsoft-button" onclick="RedirectToMicrosoftLogin(false)">Teacher</button>
			    <button class="microsoft-button tenant-button" onclick="RedirectToMicrosoftLogin(true)">Tenant Admin</button>
		    </div>
		    <h2 class="or-text">or</h2>
            <div class="alert alert-danger" style="display:none;" role="alert">
              <strong>Invalid username / password !</strong>
              <button type="button" id="closeAlert" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
		    <input type="text" id="JSAMuserName" class="form-control" placeholder="Username or Email" required autofocus>
		    <input type="password" id="JSAMPassword" class="form-control" placeholder="Password" required>
		    <a href="/academy/math/forgotpassword">Forgot Password?</a>
		    <button id="login-button" class="login-button" type="button">Login</button>
		    <button class="room-token-button" onclick="JSAM_PlayWithToken(); return false;">I have a Room Token</button>
	    </div>
        <div id="form-forgot_password" style="display:none;">
            <h2>Forgot Your Password ?</h2>
            <form>          
                    <input type="email" id="fpEmail" placeholder="Email address" class="form-control" autocomplete="off" />
                    <span id="emailSpan">Invalid Email</span>     
      
                <div class="alt-button-wrapper">
                    <button type="button" class="btn btn-info" id="fpResetPassword" onclick="SendNewPassword();" style="background: #2d61b7;" disabled>Send Email</button>
                    <span onclick="toggleBetweenLoginAndPassword();" class="link"> Back to login ?</span>
                </div>
            </form>
        </div>
        <div class="msg-reset-success" style="display: none; text-align: center;">
            <h3>Success!</h3>
            <div>
                You should receive an email shortly with instructions.
            </div>
            <div>
                 Please check your inbox (including junk mail folders) for this email.
            </div>
            <div>If you have any questions, contact
                <a href="https://www.jumpstart.com/aboutus/contact-us" style="display:inline; float:none;">JumpStart Support</a>
            </div>
        </div>
    </div>	
	<div class="jsam-grass"></div>
</body>
</html>
<style>

</style>         
    

<div class="modal request-model in" id="progressBarModal" role="dialog" aria-hidden="false" style="display: none; background-color: #266ce336; height: 100%;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>
            <div class="modal-body">
                <div id="syncProgress"> 
                  <span>Please wait while we sync your data...</span>
                    <br />
				    <div>
					    <div id="syncBar"></div>                    
				    </div>
                </div>
                <div id="expiredUser" style="display:none;">
                    <span>Oops! Your trial has expired. Click <a href="http://www.jumpstart.com/academy/">here</a> to get access.</span>
                </div>
                <div id="notSupported" style="display:none;">
                    <p>Oops! Something went wrong. Please try gain later. </p>
                    <p>If you are a parent from "Edmodo", this feature is currently unavailable. Please check back later.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
#syncProgress {
  width: 100%;
  background-color: #ddd;
}

#syncBar {
  width: 1%;
  height: 30px;
  background-color: #4CAF50;
}
</style>

<script>
    function updateProgressBar(totalDelay) {
        var elem = document.getElementById("syncBar");
        var width = 1;
        var interval = totalDelay / 100;
        var id = setInterval(frame, interval);
        function frame() {
            if (width >= 100) {
                clearInterval(id);
                $("#progressBarModal").modal('hide');
            } else {
                width++;
                elem.style.width = width + '%';
            }
        }
    }

    function displayExpiredUserMessage()
    {
        var elemSP = document.getElementById("syncProgress");
        elemSP.style.display = 'none';
        var elemEU = document.getElementById("expiredUser");
        elemEU.style.display = 'block';
    }

    function functionalityNotSupportedMessage() {
        var elemSP = document.getElementById("syncProgress");
        elemSP.style.display = 'none';
        var elemNS = document.getElementById("notSupported");
        elemNS.style.display = 'block';
    }
</script>
    <div id="loading-background">
        <div class="loading-ring"><div></div><div></div><div></div><div></div></div>
    </div>
<style>
    .alert 
    {
        max-width: 85%;
        margin: 2% auto;
    }
</style>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>    
    <script type="text/javascript" src='//media.jumpstart.com/JSWeb/CssLib/JSA/js/JSAMathHelper.js'></script> 
  
    <script type="text/javascript">
        JSAMHelper.useCleverSyncProfileAPI = true;

        function RedirectToCleverLogin() {
            JSAMHelper.RedirectToCleverLogin();
        }

        function RedirectToMicrosoftLogin(is_admin) {
            JSAMHelper.RedirectToMicrosoftLogin(is_admin);            
        }

        function RedirectToGoogleLogin() {
            JSAMHelper.RedirectToGoogleLogin();
        }

        function JSAM_PlayWithToken() {
            location.href = '/frontend/r/login?t=1';
        }

        $('#login-button').bind("click touchstart", JSAM_LoginWithIdPass);

        function JSAM_LoginWithIdPass() {
            var username = JSAMuserName.value;
            var password = JSAMPassword.value;
            if (username == '' || password == '') {
                ResetLoginUIonError();
            } else {
                JSAMHelper.LoginWithIdPass(username, password);
            }
        }

        function ResetLoginUIonError() {
            JSAMHelper.PlayErrorSound();
            $("#form-login").effect("shake", {}, 300);
            JSAMuserName.value = '';
            JSAMPassword.value = '';
            $('.alert').show();
            JSAMuserName.focus();
        }

        function ToggleMicrosoftButtons() {
            var microsoft_buttons = document.getElementById('microsoft-buttons-wrapper');
            if (microsoft_buttons.style.display === "none") {
                microsoft_buttons.style.display = "flex";
            } else {
                microsoft_buttons.style.display = "none";
            }
        }

        var minPasswordLength = 2;

        var minUsernameLength = 2;

        $('#JSAMPassword').keydown(function (e) {
            if (e.keyCode == 13 && JSAMPassword.value.length > minPasswordLength) {
                JSAM_LoginWithIdPass();
            }
        });
        $('#JSAMuserName').keydown(function (e) {
            if (e.keyCode == 13 && JSAMuserName.value.length > minUsernameLength) {
                JSAM_LoginWithIdPass();
            }
        });

        $('#closeAlert').click(function () {
            $('.alert').hide();
        });

        function showBusyAnimation(show)
        {
            var dispValue = show ? 'flex' : 'none';// .show() does 'block' therefore this ugly code. 
            $('#loading-background').css('display', dispValue);
        }

        $(document).ready(function () {
            var actionItem = getUrlQSVals()['redirect'];
            if (actionItem != undefined && actionItem.toLowerCase() == 'edmodo')
            {
                RedirectToEdmodoLogin();
            }
        });

        function getUrlQSVals() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        var JSAMAutoLoginData = {};
    
        $(window).load(function () {
            if ($('#JSAMuserName').val().length == 0) {
                setTimeout(function () { $('#JSAMuserName').val(''); }, 500);
        }
        checkCookie();
        if (JSAMAutoLoginData.parentlogin != undefined && JSAMAutoLoginData.childrenlogin != undefined && JSAMAutoLoginData.childrenlogin.length > 0)
            {
                JSAMHelper.LoginWithIdPass(JSAMAutoLoginData.childrenlogin[0].username, JSAMAutoLoginData.childrenlogin[0].password);
            document.cookie = "JSAMReg=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
        }
    });

        var checkCookie = function () {
            var jasmCookie = getCookie('JSAMReg');
            if (typeof jasmCookie != 'undefined' && jasmCookie.length > 0) {
                JSAMAutoLoginData = JSON.parse(jasmCookie);
        }
    };

        function getCookie(cname) {
            var name = cname + "=";
            var decodedCookie = decodeURIComponent(document.cookie);
            var ca = decodedCookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                c = c.substring(1);
        }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
        }
    }
    return "";
}



    </script>