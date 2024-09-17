// import firebase_admin
// from firebase_admin import credentials
// from firebase_admin import db
// import Jetson.GPIO as GPIO
//
// # Disable GPIO warnings
// GPIO.setwarnings(False)
//
// # Initialize Firebase
// cred = credentials.Certificate({
// "type": "service_account",
// "project_id": "gdid-19a24",
// "private_key_id": "f7e6ac7ab067226b4f7a25e445190aa4e5d6ae1a",
// "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCqMQPwOQHPedtK\nu80aPhNqjbIILX35mTttMCUQJaLTVVLiyc4g4sgMTUCcNXLsOYe5E81ol4eRQw3Y\nSVZUBoMmWqotYkDUSDlxOJsMf/RaCabl2LGi3svJe+dvYuHTpqf3uOl2s42GT0I3\nQpShdkmQq0pcaEaMXjiLN08co5jsc2UL/v8ykf587kFPcB3syjG6tP9wQKvq/KU5\nxO/T+9f/uj+361/2bgE12yAeM4sJDqYjRRfSaqA1EEpFez54QBE/KluaGYo7mbKM\nFYgr7JWj7zTeYGX75AabF3judDd3pLk/f6JjA2dopLllRUAZIgzHLu+nME4A+ZCV\n3w2moIK7AgMBAAECggEAFrA/yakX5DG8ZHtNLafujQsZxlGmPyhIjgGtQeNP5c40\npWDo4WUfl9WT/PR6fyJw77aY8M4ZTRS8MO7J8Eaz+jYmWgmErKgk5u1Nwj4BScrf\n8eP6/m78NOlB4mKzdLSoJMlab7AieFrIRYyokC6Fl8s2DRlQ+l/fODP7OyKrfYNH\nCKBwUhuzKDI58W8rKY2SLmrEenV1PQ0OZcswtmcamLdOj5ayf/FrZXVaJ3CNyPHf\nWNRz4YQKA9AehNvmKH8fgajynGdmIkk50hrUyetSlsWJNTkmFbdDCPzl+wKHy/Vq\ni+00fnbNuXV7HVEa/S7+J3UeBPfLVOEUeLB+A3OTRQKBgQDWblzF0JYlMcU/HK2k\nhmkmYGknjjK20DiFH4fYoDOCbtjZ2kDgErDUKRpF4c5+6DlOAVsPBxczpfhXrq98\nJNJEPDLM4PONCoW/306M4qz5WrtvFYvpGMbKFm3eWCQuRn8C8YvfcU/mSCV5TXF1\nsn2Ta8xFkyPgng/v2FgHmE5U5QKBgQDLLyi5Jj9rYMD0sMpvuplAfGjGxPSTqHzQ\nBZBk1AqQl/qkgBW/z58D2xmZBbjn4zaRJZFtFqHkUUOWQvFuIcFMqzTPBjXZgxTf\naNBA8AXghpgsgwxntNKfi0+bJYWob0s7cbO8We599ahUG1tGhHO+9+jXHJ/mwbvn\nHm/8qCKfHwKBgEMFk7GwlH1jpQco6401BcCc+cEHTQqe4kuZo1guGmt2Qgk1knl2\n3hYyEqgs/+Hiq6aZ/eAgkzvtcEXXr7nZuG7jce1fkkBPPabPITofz3jQxyzdSzG8\nMMYRZJ3OZuCf4CsHXHSmchbEDhJwBjqHY4CkfOByMRCP1uNcd4dIL5ORAoGAD5z0\nGCYkQXAR47uiEqvYEuh8dKm10ZLk5GdJDTZuCWZkUDe3dCHUKkuvz95sswT2sHie\nkC9pCU5lTyqdusTFQcr2J+JmSOyVsgUv242WJgaxstnvHhj7Bl+CIn3jo2nJ8itu\nkE6o0O0Lnkrr3KNY8ZfDQKRmdSj183CXUmbpIikCgYAdQwI6Hab8NZbKFxWSvy5d\nOf69lC/42+HuvB66OFPSMCvwb8/sFH209jdweTEuaGu1cFcwS8b1U5SoPAev/U2D\nYn5FaTPacyxNIjzQATarVtRamOfehFd7DQdxn2IwY3NMBxw1QAMip816jS7JUanu\ncYHecrFpmID3RxFt2wX5Dw==\n-----END PRIVATE KEY-----\n",
// "client_email": "firebase-adminsdk-36kcu@gdid-19a24.iam.gserviceaccount.com",
// "client_id": "110624364375496822721",
// "auth_uri": "https://accounts.google.com/o/oauth2/auth",
// "token_uri": "https://oauth2.googleapis.com/token",
// "auth_provider_x509_cert_url": "https://www.googleapis.com/v1/certs",
// "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-36kcu%40gdid-19a24.iam.gserviceaccount.com",
// "universe_domain": "googleapis.com"
// })
//
// firebase_admin.initialize_app(cred, {
// 'databaseURL': 'https://gdid-19a24-default-rtdb.firebaseio.com/'
// })
//
// # Set up the LED pin
// LED_PIN = 18
// GPIO.setmode(GPIO.BOARD)
// GPIO.setup(LED_PIN, GPIO.OUT)
//
// # Reference the database
// ref = db.reference('output/state')
//
// # Function to update the LED state
// def update_led(event):
// state = event.data
// if state == 'on':
// GPIO.output(LED_PIN, GPIO.HIGH)
// print("LED turned on")
// else:
// GPIO.output(LED_PIN, GPIO.LOW)
// print("LED turned off")
//
// # Listen for changes in the database
// ref.listen(update_led)
//
// # Keep the script running
// try:
// while True:
// pass
// except KeyboardInterrupt:
// # Clean up the GPIO pins
// GPIO.cleanup()
