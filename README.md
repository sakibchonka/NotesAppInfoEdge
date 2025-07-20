Design: https://www.figma.com/file/Mh6Jb8gBxT9MewfWkKNwOV/Tech-Challenge?node-id=0%3A1



Here are the APIs to implement:



Base URL: https://app.aisle.co/V1
Name: Phone number API
Method: POST
End Point:  /users/phone_number_login
Parameter: {'number' = "+919876543212"}


Name: OTP API
End Point: /users/verify_otp
Method: POST
Parameter: {'number' = "+919876543212", 'otp' => "1234"}


Name: Notes API
Method: GET
End Point: /users/test_profile_list
Header: {'Authorization' = ‘auth_token" 


Description

Screen 1: Enter +91 in the country code field and 9876543212 in the phone number field and click on the Continue button. While clicking on the Continue button make a Phone number API call, Once you get success response then take the user to Screen 2.

Screen 2: Enter 1234 in the OTP field and click on the Continue button. While clicking on the Continue button, make an OTP API call, You will receive an auth token in the API success response then take the user to Screen 3.

Screen 3: Add auth token in the header while making Notes API call.
