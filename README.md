# AFBank

## Description

AFBank is a bank-like application where users can have accounts, make transfers to other accounts (after adding those accounts as contacts), and track transactions made from/to their accounts. The project leverages Rails 7 with Hotwire (Turbo + Stimulus) to provide a modern and dynamic user experience. The goal of this project is to practice Rails 7 features, understand security concerns like account security and safe transactions (using atomic transactions for the database), and complete a full-fledged project.

## Goals

- Practice Rails 7 with Hotwire (Turbo + Stimulus) features
- Understand and implement security concerns like account security and safe transactions
- Complete a full project with practical functionalities

## Setup and Running Instructions

### Prerequisites

- Docker
- Docker Compose

### Installation

1. **Install Docker**

   Follow the instructions to install Docker for your operating system:

   - [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
   - [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
   - [Docker for Linux](https://docs.docker.com/engine/install/)

2. **Install Docker Compose**

   Docker Compose is typically included with Docker Desktop for Windows and Mac. For Linux, you can follow the instructions here:

   - [Install Docker Compose](https://docs.docker.com/compose/install/)

### Running the Application

1. **Clone the Repository**

   ```sh
   git clone https://github.com/yourusername/afbank.git
   cd afbank
   ```

2. **Build and Start the Containers**

   From the root directory of the project, run the following command to build and start the containers:

   ```sh
   docker-compose up --build
   ```

3. **Setup the Database**

   Once the containers are up and running, set up the database by running:

   ```sh
   docker-compose run web rails db:setup
   ```

4. **Access the Application**

   Open your web browser and go to `http://localhost:3000` to access the AFBank application.

### Stopping the Application

To stop the application, run:

```sh
docker-compose down
```

# Contributing

This is a case study project, it is not intended to be used in real applications or to be extended.
For these reasons, it remains archived.
