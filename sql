CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Password will be stored in hashed format
    role VARCHAR(20) CHECK (role IN ('Alumni', 'Student', 'Admin')) NOT NULL,
    profile_image TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE Alumni (
    alumni_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,  -- One-to-one relationship with Users
    graduation_year INT,
    specialization VARCHAR(100),
    current_position VARCHAR(100),
    company VARCHAR(100),
    location VARCHAR(100),
    career_path TEXT,
    contact_info TEXT,  -- Can store phone, LinkedIn, etc.
    areas_of_expertise TEXT,
    mentorship_availability BOOLEAN DEFAULT FALSE,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,  -- One-to-one relationship with Users
    current_year INT,
    course VARCHAR(100),
    specialization VARCHAR(100),
    interests TEXT,
    career_goals TEXT,
    seeking_mentorship BOOLEAN DEFAULT FALSE,
    resume TEXT,  -- Path to resume file
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Mentorship_Programs (
    mentorship_id SERIAL PRIMARY KEY,
    mentor_id INT NOT NULL,  -- Refers to an Alumni user
    mentee_id INT NOT NULL,  -- Refers to a Student user
    start_date DATE,
    end_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Completed', 'Canceled')) DEFAULT 'Active',
    goal TEXT,
    feedback TEXT,
    FOREIGN KEY (mentor_id) REFERENCES Alumni(alumni_id) ON DELETE CASCADE,
    FOREIGN KEY (mentee_id) REFERENCES Students(student_id) ON DELETE CASCADE
);

CREATE TABLE Interactions (
    interaction_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,  -- The user who initiated the interaction
    type VARCHAR(50),  -- Forum Post, Private Message, etc.
    content TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_flagged BOOLEAN DEFAULT FALSE,  -- If flagged for inappropriate content
    response_to INT,  -- If this is a reply to another interaction (for threaded discussions)
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (response_to) REFERENCES Interactions(interaction_id) ON DELETE CASCADE
);

CREATE TABLE Events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    event_type VARCHAR(50),  -- Meetup, Webinar, etc.
    description TEXT,
    date_time TIMESTAMP,
    location VARCHAR(100),  -- Can be physical or virtual
    created_by INT,  -- Admin or Alumni (user_id)
    recording_link TEXT,  -- For webinars
    FOREIGN KEY (created_by) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Event_Participants (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    feedback TEXT,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,  -- Storing hashed passwords
    phone VARCHAR(15),
    role VARCHAR(50) NOT NULL CHECK (role IN ('Student', 'Alumni', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

