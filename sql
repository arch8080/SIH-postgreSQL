CREATE TABLE Alumni (
    alumni_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    specialization VARCHAR(255),
    industry VARCHAR(255),
    current_position VARCHAR(255),
    company_name VARCHAR(255),
    graduation_year INT,
    achievements TEXT,
    location VARCHAR(255)
);
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    department VARCHAR(255),
    year_of_study INT,
    interests TEXT,
    career_goals TEXT
);
CREATE TABLE Mentorship_Requests (
    request_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE,
    alumni_id INT REFERENCES Alumni(alumni_id) ON DELETE CASCADE,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    description TEXT
);
CREATE TABLE Interactions (
    interaction_id SERIAL PRIMARY KEY,
    thread_title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    user_id INT,
    user_type VARCHAR(10) CHECK (user_type IN ('student', 'alumni')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    parent_interaction INT REFERENCES Interactions(interaction_id) ON DELETE SET NULL
);
CREATE TABLE Events (
    event_id SERIAL PRIMARY KEY,
    event_title VARCHAR(255) NOT NULL,
    event_description TEXT,
    event_date DATE NOT NULL,
    location VARCHAR(255),
    organizer_id INT REFERENCES Alumni(alumni_id) ON DELETE SET NULL,
    event_type VARCHAR(50) CHECK (event_type IN ('webinar', 'panel discussion', 'meetup'))
);
