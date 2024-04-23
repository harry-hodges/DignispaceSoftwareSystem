# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include BCrypt

users = User.create!([
    {
        name: "Admin Adminson",
        email: "admin@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_ADMIN"
    },
    {
        name: "Healthcare Professsional",
        email: "prof@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_PROFESSIONAL"
    },
    {
        name: "Patient Patientson",
        email: "patient1@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_USER"
    },
    {
        name: "Second Patient Patientson",
        email: "patient2@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_USER"
    },
    {
        name: "Viewer Viewerson",
        email: "viewer1@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_USER"
    },
    {
        name: "Second Viewer Viewerson",
        email: "viewer2@shef.ac.uk",
        hhash: Password.create("qwe"),
        role: "ROLE_USER"
    },
    {
        name: "William Jeynes",
        email: "william@willjay.rocks",
        hhash: Password.create("qwe"),
        role: "ROLE_ADMIN"
    }
])

groups = UserGroup.create([
    {
        image: "https://images.unsplash.com/photo-1511884642898-4c92249e20b6",
        name: "Patient Patientson's Record"
    }
])

roles = UserRole.create([
    {
        role: "ROLE_PROFESSIONAL",
        user_group_id: groups[0].id,
        user_id: users[1].id
    },    
    {
        role: "ROLE_PATIENT",
        user_group_id: groups[0].id,
        user_id: users[2].id
    },
    {
        role: "ROLE_VIEWER",
        user_group_id: groups[0].id,
        user_id: users[3].id
    },
    {
        role: "ROLE_VIEWER",
        user_group_id: groups[0].id,
        user_id: users[4].id
    },
    {
        role: "ROLE_VIEWER",
        user_group_id: groups[0].id,
        user_id: users[5].id
    }
])

questions = Question.create([
    {
        title: "Bucket list",
        contents: "A longer explanation of the bucket list question",
        sensitivity: "LOW",
    },    
    {
        title: "Regrets",
        contents: "A longer explanation of the regrets question",
        sensitivity: "HIGH",
    },
])

answers = Answer.create([
    {
        contents: "Response with a flag",
        question_id: questions[0].id,
        user_group_id: groups[0].id
    },    
    {
        contents: "Response with an edit",
        question_id: questions[1].id,
        user_group_id: groups[0].id
    },
])

flags = Flag.create([
    {
        active: true,
        reason: "Bad content",
        answer_id: answers[0].id
    }
])

potentialEdits = PotentialEdit.create([
    {
        accepted: false,
        editContents: "More positive response from therapy session",
        answer_id: answers[1].id
    }
])

auditLogs = AuditLogEntry.create([
    {
        action: "DB Create",
        details: "Audit log generated with generation of database seeding",
        answer_id: answers[0].id,
        user_id: users[6].id
    }
])

alerts = Alert.create([
    {
        active: 1,
        description: "Alert generated with creation of the DB seeds",
        high_priority: true,
        topic: "SYSADMIN notifications",
        web_link: "https://google.com",
        user_id: users[6].id
    }
])

prefs = Preference.create([
    {
       name: "Theme",
       value: "Dark",
       user_id: users[6].id
    }
])

bubbles = Bubble.create([
    {
       name: "Family",
        user_group_id: groups[0].id
    }
])

userbubbles = UserBubble.create([
    {
       bubble_id: bubbles[0].id,
        user_id: users[4].id
    }
])

answerbubbles = AnswerBubble.create([
    {
       bubble_id: bubbles[0].id,
        answer_id: answers[0].id
    }
])