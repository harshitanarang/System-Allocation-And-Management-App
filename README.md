# System Allocation and Management App

A **Java-based Web application** for managing system allocation and complaints in an organization. Built using **Java**, **JDBC**, and **MySQL**, the app allows admins to allocate systems to employees and track complaints efficiently.

---

## Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- Admin dashboard to manage employees and system allocations.
- Employee registration and system allocation tracking.
- Complaint registration and management system.
- Database-driven backend using MySQL.
- Simple and intuitive Java GUI.

---

## Technologies Used
- **Java SE**  
- **JDBC** for database connectivity  
- **MySQL** for storing employee and system data  
- **Eclipse IDE** for development  

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/harshitanarang/System-Allocation-And-Management-App.git

2.Open the project in Eclipse IDE.
3.Create a MySQL database and update config.properties with your credentials:
    db.url=jdbc:mysql://localhost:3306/your_database
    db.username=your_username
    db.password=your_password
    
4.Build and run the project from Eclipse.


## Usage

1. Launch the application from Eclipse.

2. Use the **admin dashboard** to:
   - Add employees
   - Allocate systems
   - View or resolve complaints

3. Employees can:
   - View their allocated systems
   - Register complaints


## Project Structure

```   
System Allocation And Management App/
├── src/                 # Source code
├── bin/                 # Compiled classes
├── .gitignore           # Git ignore file
├── config.properties    # Database configuration (ignored in Git)
├── .classpath           # Eclipse metadata
├── .project             # Eclipse metadata
└── .settings/           # Eclipse project settings
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.

2. Create a new branch:
   git checkout -b feature-name
   
3. Commit your changes:
   git commit -m "Add feature"
   
4. Push to the branch:
   git push origin feature-name

5. Create a Pull Request on GitHub.

## License
This project is licensed under the [MIT License](LICENSE).

   



    
