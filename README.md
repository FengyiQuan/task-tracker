# task-tracker

This is a web application designed to help users track their tasks and manage their to-do lists. Users can create, edit, and delete tasks, set due dates and priorities, and mark tasks as completed.

## Architecture

The Task Tracker Web App is built using Rust programming language and is deployed on Amazon Web Services (AWS) using Elastic Kubernetes Service (EKS) as the container orchestration platform. The application is containerized using Docker and stored in Elastic Container Registry (ECR).

The backend of the application uses Actix-Web framework, and data is stored in a DynamoDB NoSQL database. The frontend is built using React, and served by an NGINX web server.

The AWS infrastructure is provisioned using Infrastructure as Code (IaC) using AWS CloudFormation, and the Kubernetes deployment is managed using Helm charts.

## Features

- **Create new tasks**: Users can create new tasks with a title, description, due date, and priority level.
- Edit tasks: Users can edit the details of existing tasks, including the title, description, due date, and priority level.
- Delete tasks: Users can delete tasks from their task list.
- Mark tasks as completed: Users can mark tasks as completed and they will be removed from their task list.
- Sort tasks: Users can sort their task list by due date, priority level, or status.
- Search tasks: Users can search for specific tasks by title or description.

## Getting Started

To run the web app locally, follow these steps:

1. Clone the repository to your local machine.
2. Install Rust and Docker on your machine.
3. Install dependencies by running `cargo build` in the root directory.
4. Start the server by running `cargo run` in the root directory.
5. Open your web browser and go to http://localhost:8080 to view the app.

## Future Improvements

- User authentication: Add user authentication to allow users to create accounts and save their task lists.
- Reminders: Add the ability to set reminders for tasks.
- Mobile responsiveness: Improve the design for mobile devices.
- Collaboration: Add the ability to share task lists with other users.
