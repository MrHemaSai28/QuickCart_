<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>QuickCart – Login / Register</title>
<style>
* {
	box-sizing: border-box;
	font-family: Segoe UI, Arial, sans-serif
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background: #f5f6fa;
	margin: 0
}

.card {
	width: 360px;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 6px 16px rgba(0, 0, 0, .15)
}

h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #444
}

form {
	display: flex;
	flex-direction: column;
	gap: 14px
}

input, select {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	width: 100%
}

button {
	padding: 10px;
	background: #1976d2;
	color: #fff;
	border: none;
	border-radius: 6px;
	cursor: pointer
}

button:hover {
	background: #0d47a1
}

.toggle {
	text-align: center;
	margin-top: 10px;
	font-size: 14px
}

.toggle a {
	color: #1976d2;
	text-decoration: none
}

.hidden {
	display: none
}

.error {
	color: #e53935;
	font-size: 13px;
	text-align: center;
	margin-top: -8px
}

.slide {
	transition: all .4s ease
}
</style>
</head>
<body>
	<div class="card slide" id="loginCard">
		<h2>Login</h2>
		<form action="auth" method="post">
			<input type="hidden" name="action" value="login">
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" name="password" placeholder="Password"
				required>
			<button type="submit">Login</button>
		</form>
		<div class="toggle">
			Don’t have an account? <a href="#" onclick="showRegister(event)">Create
				one</a>
		</div>
	</div>

	<div class="card slide hidden" id="registerCard">
		<h2>Create Account</h2>
		<form action="auth" method="post" onsubmit="return checkPasswords()">
			<input type="hidden" name="action" value="register">
			<input type="text" name="name" placeholder="Full Name" required>
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" id="pass" name="password"
				placeholder="Password" required> <input type="password"
				id="cpass" placeholder="Confirm Password" required> <select
				name="role">
				<option value="customer">Customer</option>
				<option value="admin">Admin</option>
			</select>
			<button type="submit">Register</button>
			<p id="error" class="error hidden">Passwords do not match.</p>
		</form>
		<div class="toggle">
			Already have an account? <a href="#" onclick="showLogin(event)">Login
				here</a>
		</div>
	</div>

	<script>
		const loginCard = document.getElementById('loginCard');
		const regCard = document.getElementById('registerCard');

		function showRegister(e) {
			e.preventDefault();
			loginCard.classList.add('hidden');
			regCard.classList.remove('hidden');
		}
		function showLogin(e) {
			e.preventDefault();
			regCard.classList.add('hidden');
			loginCard.classList.remove('hidden');
		}
		function checkPasswords() {
			const p = document.getElementById('pass').value;
			const cp = document.getElementById('cpass').value;
			const err = document.getElementById('error');
			if (p !== cp) {
				err.classList.remove('hidden');
				return false; // prevent submit
			}
			err.classList.add('hidden');
			return true; // allow submit
		}
	</script>

</body>
</html>
