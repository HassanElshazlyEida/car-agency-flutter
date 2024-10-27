# Flutter Project Setup Documentation

## Creating the `.env` File

Before running the Flutter project, you need to create a `.env` file in the root directory of your Flutter application. This file will hold the environment variables required for the project to connect to the services and manage credentials.

### Step 1: Create the `.env` File

1. Navigate to the root directory of your Flutter project.
2. Create a new file named `.env`.

### Step 2: Add the Required Credentials

Open the `.env` file you just created and add the following credentials:

```plaintext
USERS_SERVICE_API=http://localhost:8001/api/v1
CARS_SERVICE_API=http://localhost:8002/api/v1

PUSHER_APP_KEY=
PUSHER_APP_CLUSTER=
PUSHER_CHANNEL=cars # in our case
```
### Step 3: Install Required Packages
- Make sure you have the necessary packages added to your pubspec.yaml. You will need packages for environment variable management and Pusher:
- Run the following command in the terminal to install these packages:
```bash
flutter pub get
```
### Step 4: Run the Project
```bash
flutter run
```