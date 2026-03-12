---
name: teaching-patterns
description: >
  Teaching patterns for bootcamps and courses: curriculum design, learner progression, and real-world projects.
  Trigger: When designing courses, creating learning paths, or structuring bootcamp curriculum.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Bootcamp Curriculum Structure (12-Week Model)

```
Week 1-2: Foundations
├── HTML5, CSS3 Fundamentals
├── JavaScript Basics (variables, functions, loops)
└── Git & GitHub workflow

Week 3-4: Client-Side Scripting
├── DOM Manipulation
├── Async/Promises/Async-Await
├── Fetch API & HTTP Requests
└── Project: Interactive Web Page

Week 5-6: Frontend Framework
├── React Basics (components, props, state)
├── Hooks (useState, useEffect, useContext)
├── Component Lifecycle & Performance
└── Project: React Todo App with API

Week 7-8: Styling & Design
├── Tailwind CSS or Bootstrap
├── Responsive Design
├── Component Libraries
└── Project: Redesign Todo App with Styling

Week 9-10: Backend Development
├── Node.js/Python Fundamentals
├── REST API Design
├── Database (SQL/NoSQL)
├── Authentication & Authorization
└── Project: Full API with Database

Week 11-12: Full Stack Integration
├── Frontend ↔ Backend Integration
├── Deployment (Docker, Vercel, Heroku)
├── Testing & Quality Assurance
└── Capstone Project: Full Stack Application
```

## Learner Progression Levels

```
Level 1: Novice (Week 1-4)
├── Learns: Syntax, basic concepts
├── Focus: Understanding fundamentals
├── Projects: Single-file scripts
└── Success Metric: Code runs, minimal errors

Level 2: Beginner (Week 5-8)
├── Learns: Frameworks, patterns
├── Focus: Building small features
├── Projects: Multi-file applications
└── Success Metric: Works as expected, some refactoring

Level 3: Intermediate (Week 9-12)
├── Learns: Architecture, best practices
├── Focus: Building scalable applications
├── Projects: Full stack applications
└── Success Metric: Clean code, tested, deployed
```

## Course Content Organization

```
course-content/
├── 01-foundations/
│   ├── README.md              # Learning objectives
│   ├── slides.pdf             # Presentation
│   ├── notes.md               # Detailed notes
│   ├── exercises/
│   │   ├── 01-variables.js    # Starter code
│   │   ├── 02-functions.js
│   │   └── solutions/         # Solutions (hidden from students)
│   ├── projects/
│   │   └── simple-calculator/ # Step-by-step guide
│   └── resources.md           # References & links
├── 02-dom-manipulation/
│   └── ... (same structure)
└── 12-deployment/
    └── ... (same structure)
```

## Learning Objectives Template (Bloom's Taxonomy)

```markdown
## Week 3: DOM Manipulation

### Learning Objectives
By the end of this week, students will be able to:

#### Remember (Basic recall)
- [ ] Recall the DOM structure and hierarchy
- [ ] Identify JavaScript methods for DOM selection

#### Understand (Explain concepts)
- [ ] Explain querySelector vs getElementById
- [ ] Describe event propagation (bubbling, capturing)

#### Apply (Use knowledge)
- [ ] Select DOM elements with querySelector
- [ ] Add/remove event listeners to elements

#### Analyze (Break down concepts)
- [ ] Analyze when to use event delegation
- [ ] Compare querySelector performance vs other methods

#### Evaluate (Make judgments)
- [ ] Evaluate best practices for DOM manipulation
- [ ] Choose appropriate methods for specific tasks

#### Create (Produce something new)
- [ ] Build interactive form with validation
- [ ] Create DOM-based game (2048, Snake)
```

## Hands-On Project Progression

```
Project 1: Calculator (Week 2)
├── Requirements: +, -, *, / operations
├── Starter Code: HTML + CSS provided
├── Learning: JavaScript functions, event handling
├── Time: 2-3 hours
└── Rubric:
    ├── Functionality (40%): All operations work
    ├── Code Quality (30%): Clean, readable code
    ├── UI/UX (20%): User-friendly interface
    └── Testing (10%): Edge cases handled

Project 2: Todo App (Week 6)
├── Requirements: Add, edit, delete, filter todos
├── Starter Code: Minimal starter template
├── Learning: React, state management, API
├── Time: 8 hours
└── Rubric:
    ├── Features (40%): All CRUD operations
    ├── React Patterns (30%): Proper hooks usage
    ├── Styling (20%): Responsive design
    └── Testing (10%): Unit tests for logic

Project 3: Full Stack (Week 12)
├── Requirements: Choose your idea OR use template
├── Starter Code: Boilerplate, no business logic
├── Learning: Full stack architecture, deployment
├── Time: 20+ hours
├── Team: Groups of 2-3
└── Rubric:
    ├── Architecture (30%): Clean layers
    ├── Features (30%): Working application
    ├── Deployment (20%): Deployed & accessible
    ├── Testing (10%): Tests coverage 60%+
    └── Documentation (10%): Clear README
```

## Teaching Methods by Topic

### For Conceptual Topics (45 min class)

```
1. Hook (10 min): Real-world example
   "Why does React use hooks? Look at this code evolution..."

2. Teach (20 min): Explain with slides + diagrams
   - Show problem without hooks
   - Introduce solution
   - Show syntax & examples

3. Demo (10 min): Live coding
   - Build simple component with hooks
   - Show common mistakes
   - Answer questions

4. Practice (5 min): In-class exercise
   - Simple follow-along
   - Pair programming
```

### For Hands-On Topics (90 min class)

```
1. Introduction (10 min): Why this matters?

2. Guided Tutorial (30 min): Step-by-step walkthrough
   - Show each step
   - Explain reasoning
   - Students follow along

3. Breakout Practice (30 min): Groups of 2-3
   - Starter code provided
   - Minimal requirements
   - Ask questions

4. Show & Tell (15 min): Groups present solutions
   - Celebrate different approaches
   - Discuss improvements

5. Homework (5 min): Preview next session
```

## Assessment Strategies

### Formative Assessment (During course)

```python
# Coding exercises - Python example
# Week 3 Exercise: List comprehensions

def test_square_numbers():
    """Students implement this function"""
    def square_numbers(numbers: list) -> list:
        # TODO: Implement using list comprehension
        pass
    
    assert square_numbers([1, 2, 3, 4]) == [1, 4, 9, 16]
    assert square_numbers([]) == []
    assert square_numbers([-1, 0, 1]) == [1, 0, 1]

# Rubric: 1-4 points
# 1: Incorrect or doesn't run
# 2: Works but inefficient approach
# 3: Works correctly (meets requirements)
# 4: Works + shows advanced understanding
```

### Summative Assessment (End of course)

```
## Capstone Project Rubric (100 points)

### Architecture (20 points)
- [ ] Clear separation of concerns (5)
- [ ] Proper use of design patterns (5)
- [ ] Scalable structure (5)
- [ ] Documentation of architecture (5)

### Code Quality (25 points)
- [ ] Readable, maintainable code (10)
- [ ] Follows style guide (5)
- [ ] Proper error handling (5)
- [ ] DRY principle applied (5)

### Features (20 points)
- [ ] All required features implemented (15)
- [ ] Works without bugs (5)

### Testing (15 points)
- [ ] Unit tests written (8)
- [ ] Integration tests (4)
- [ ] 60%+ code coverage (3)

### Deployment (10 points)
- [ ] Deployed to production (5)
- [ ] Accessible and working (5)

### Presentation (10 points)
- [ ] Clear explanation (5)
- [ ] Confident delivery (5)
```

## Student Engagement Techniques

### Active Learning

```
1. Think-Pair-Share (15 min)
   Step 1: Individual thinking (3 min)
   Step 2: Pair discussion (5 min)
   Step 3: Class sharing (7 min)
   
   Example: "How would you structure this app?"

2. Peer Code Review (30 min)
   - Students review peer's code
   - Use rubric
   - Provide constructive feedback
   
3. Coding Challenges (20 min)
   - Daily coding problem
   - Students solve & discuss
   - Gamify with leaderboard

4. Guest Speakers (60 min)
   - Industry professionals
   - Q&A from students
   - Real-world perspective
```

### Motivation & Retention

```
✅ What works:
- Early success (easy wins in Week 1)
- Visible progress (track projects)
- Real-world relevance (use actual APIs)
- Community (cohort bonds)
- Celebration (showcase projects)
- Support (mentoring, office hours)

❌ Avoid:
- Too difficult too soon
- Irrelevant content
- Lack of feedback
- Isolation (no peer interaction)
- Generic projects
```

## Curriculum Milestones

```
Week 0 (Before): Setup & Pre-Course Assessment
├── Setup development environment
├── Pre-assessment quiz (HTML, CSS, JavaScript knowledge)
├── Introduce course platform & tools
└── Team building activity

Week 4: First Milestone - Complete Projects
├── Code review session
├── Peer feedback
├── Celebrate progress
└── Adjust pace if needed

Week 8: Second Milestone - Intermediate Checkpoint
├── Mock interview preparation
├── Portfolio project start
├── Guest speaker: Industry expert
└── Midterm assessment

Week 12: Final Milestone - Capstone Defense
├── Presentations & demos
├── Peer evaluation
├── Industry feedback (if possible)
└── Graduation & job prep

Post-Course: Alumni Network
├── Job placement support
├── Continued learning resources
├── Alumni events
└── Mentorship opportunities
```

## Handling Different Learning Styles

```
Visual Learners:
- Diagrams and flowcharts
- Screen recordings
- Animated explanations
- Color-coded syntax highlighting

Auditory Learners:
- Lectures and discussions
- Pair programming explanations
- Podcast-style resources
- Q&A sessions

Kinesthetic Learners:
- Hands-on coding exercises
- Group projects
- Interactive demos
- Trial-and-error exploration

Reading/Writing Learners:
- Detailed notes
- Code comments & documentation
- Written summaries
- Blog posts & articles
```

## Common Teaching Mistakes

```
❌ Too Fast (Cognitive Overload)
   - Avoid: Covering too much per class
   - Instead: Deep dive into fundamentals

❌ Not Relevant (Disconnection)
   - Avoid: "Hello World" forever
   - Instead: Build real projects early

❌ All Lectures (Passive)
   - Avoid: 4 hours of talking
   - Instead: 40% teaching, 60% practice

❌ No Feedback (Students Lost)
   - Avoid: Exercises without solutions
   - Instead: Regular code reviews

❌ Same Level (Pacing Issues)
   - Avoid: Assuming everyone at same level
   - Instead: Provide bonus/remedial tracks
```

## Tools & Platforms

```
Teaching & Learning:
- Git/GitHub: Version control lessons
- CodeSandbox: Live coding environments
- Replit: Browser-based IDE
- Glitch: Remixable projects
- Notion/Obsidian: Course notes

Assessment:
- HackerRank: Coding challenges
- LeetCode: Interview prep
- CodeWars: Gamified challenges
- Quizlet: Flashcards & quizzes

Collaboration:
- Discord: Community & support
- Slack: Real-time help
- Zoom: Live sessions
- GitHub: Code collaboration
```

## Best Practices Checklist

- ✅ Clear learning objectives per week
- ✅ Mix of theory and hands-on practice
- ✅ Real-world projects (not toy problems)
- ✅ Regular feedback and assessment
- ✅ Support for different learning styles
- ✅ Community and peer learning
- ✅ Early success to build confidence
- ✅ Job preparation in final weeks
- ✅ Alumni support after graduation
- ✅ Continuous curriculum improvement
- ✅ Inclusive and accessible content
- ✅ Celebrate student achievements

## Keywords
teaching, bootcamp, curriculum, learning-objectives, pedagogy, student-engagement, assessment, projects
