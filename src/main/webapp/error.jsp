<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Not Found</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            --accent-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background with moving gradients */
        body::before {
            content: '';
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle at 30% 70%, rgba(255, 255, 255, 0.15) 0%, transparent 60%),
                        radial-gradient(circle at 70% 30%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 50% 50%, rgba(102, 126, 234, 0.1) 0%, transparent 70%);
            animation: backgroundMove 25s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        @keyframes backgroundMove {
            0%, 100% { transform: rotate(0deg) scale(1); }
            33% { transform: rotate(120deg) scale(1.1); }
            66% { transform: rotate(240deg) scale(0.9); }
        }

        /* Floating geometric shapes */
        .floating-shape {
            position: fixed;
            opacity: 0.6;
            animation: floatShape 20s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        .floating-shape:nth-child(1) {
            width: 100px;
            height: 100px;
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.1), rgba(102, 126, 234, 0.2));
            border-radius: 50%;
            top: 10%;
            left: 80%;
            animation-delay: 0s;
        }

        .floating-shape:nth-child(2) {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, rgba(250, 112, 154, 0.3), rgba(254, 225, 64, 0.2));
            clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
            top: 70%;
            left: 15%;
            animation-delay: 7s;
        }

        .floating-shape:nth-child(3) {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, rgba(79, 172, 254, 0.2), rgba(0, 242, 254, 0.3));
            border-radius: 20px;
            top: 30%;
            right: 20%;
            animation-delay: 14s;
        }

        @keyframes floatShape {
            0%, 100% { 
                transform: translateY(0px) translateX(0px) rotate(0deg) scale(1); 
                opacity: 0.6; 
            }
            25% { 
                transform: translateY(-50px) translateX(30px) rotate(90deg) scale(1.2); 
                opacity: 0.8; 
            }
            50% { 
                transform: translateY(-20px) translateX(-40px) rotate(180deg) scale(0.8); 
                opacity: 0.4; 
            }
            75% { 
                transform: translateY(30px) translateX(20px) rotate(270deg) scale(1.1); 
                opacity: 0.7; 
            }
        }

        .error-container {
            max-width: 500px;
            width: 100%;
            animation: containerEntrance 1s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes containerEntrance {
            0% {
                opacity: 0;
                transform: scale(0.7) translateY(100px) rotateX(20deg);
            }
            100% {
                opacity: 1;
                transform: scale(1) translateY(0) rotateX(0deg);
            }
        }

        .error-box {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(30px);
            border: none;
            border-radius: 35px;
            padding: 60px 50px;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.4),
                0 0 0 1px rgba(255, 255, 255, 0.1);
            position: relative;
            overflow: hidden;
        }

        /* Animated border effect */
        .error-box::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: conic-gradient(
                from 0deg,
                transparent,
                rgba(102, 126, 234, 0.8),
                rgba(118, 75, 162, 0.6),
                rgba(240, 147, 251, 0.4),
                transparent
            );
            border-radius: 37px;
            animation: rotateBorder 8s linear infinite;
            z-index: -1;
        }

        @keyframes rotateBorder {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .error-icon {
            font-size: 4rem;
            color: #ff6b6b;
            margin-bottom: 30px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .error-title {
            color: white;
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #fff 0%, #f0f8ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 3px 15px rgba(255, 255, 255, 0.4);
            animation: titleShimmer 4s ease-in-out infinite;
        }

        @keyframes titleShimmer {
            0%, 100% { filter: brightness(1) contrast(1); }
            50% { filter: brightness(1.3) contrast(1.1); }
        }

        .error-message {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .register-btn {
            background: var(--accent-gradient);
            border: none;
            border-radius: 30px;
            color: white;
            font-size: 1.3rem;
            font-weight: 700;
            padding: 20px 40px;
            cursor: pointer;
            transition: all 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            overflow: hidden;
            box-shadow: 
                0 15px 40px rgba(250, 112, 154, 0.5),
                inset 0 2px 0 rgba(255, 255, 255, 0.4);
            text-decoration: none;
            display: inline-block;
            margin-right: 15px;
        }

        /* Button shine effect */
        .register-btn::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transform: rotate(45deg);
            transition: transform 0.8s ease;
        }

        .register-btn:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 25px 50px rgba(250, 112, 154, 0.7),
                0 0 0 3px rgba(255, 255, 255, 0.2),
                inset 0 2px 0 rgba(255, 255, 255, 0.4);
        }

        .register-btn:hover::before {
            transform: rotate(45deg) translateX(100%);
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 30px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 18px 35px;
            cursor: pointer;
            transition: all 0.4s ease;
            text-decoration: none;
            display: inline-block;
            backdrop-filter: blur(10px);
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-4px);
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* Responsive */
        @media (max-width: 450px) {
            .error-box {
                padding: 40px 30px;
                border-radius: 30px;
            }

            .error-title {
                font-size: 2.2rem;
            }

            .register-btn, .back-btn {
                display: block;
                margin: 10px auto;
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Floating shapes -->
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>

    <div class="error-container">
        <div class="error-box">
            <h1 class="error-title">Account Not Found</h1>
            <p class="error-message">The account you're trying to access doesn't exist in our system. Please register to create a new account.</p>
            <a href="register.html" class="register-btn">Register Now</a>
            <a href="index.html" class="back-btn">Back to Login</a>
        </div>
    </div>
</body>
</html>