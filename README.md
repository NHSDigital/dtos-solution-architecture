# DToS Solution Architecture Repository

## Introduction

This repository contains two main components:

1. **Solution Architecture Model**: Using the DSL Structurizr for generating architecture diagrams
2. **Event Catalog**: A documentation tool for managing and documenting events in the system

The architecture diagrams generated by Structurizr are referenced within Confluence for the wider team to access.

## Repository Structure

- `/structurizr`: Contains the solution architecture model and related files
- `/eventcatalog/nhse-screening-eventcatalog`: Contains the Event Catalog application for documenting system events

## Getting Started

### 1. Solution Architecture Model (Structurizr)

To work with the solution architecture model, you'll need to run Structurizr Lite locally. This requires Docker installation.

#### Prerequisites

- Docker installed from [https://www.docker.com/get-started/](https://www.docker.com/get-started/)

#### Running Structurizr

First, pull the latest Structurizr lite image:

```bash
docker pull structurizr/lite
```

Clone the repository

HTTPS
```bash
git clone https://github.com/NHSDigital/dtos-solution-architecture.git
```

SSH
```bash
git clone git@github.com:NHSDigital/dtos-solution-architecture.git
```

Then run the container (commands vary by operating system):

##### MacOS and Linux

```bash
cd dtos-solution-architecture/eventcatalog/nhse-screening-catalog
docker run -it --rm -p 8080:8080 -v ./:/usr/local/structurizr structurizr/lite
```

Note: For MacOS Sequoia 15.2 and later, use this command instead to avoid sigterm exceptions:

```bash
cd dtos-solution-architecture/eventcatalog/nhse-screening-catalog
docker run --rm -e JAVA_TOOL_OPTIONS="-XX:UseSVE=0" -p 8080:8080 -v ./:/usr/local/structurizr structurizr/lite
```

##### Windows

```bash
cd dtos-solution-architecture/eventcatalog/nhse-screening-catalog
docker run -it --rm -p 8080:8080 -v %cd%:/usr/local/structurizr structurizr/lite
```

Once running, access the live view at http://localhost:8080

### 2. Event Catalog

The Event Catalog is located in the `/dtos-solution-architecture/eventcatalog/nhse-screening-catalog` directory and contains documentation for system events. Each event is documented with its schema and related information.

#### Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)

#### Installation

1. Navigate to the eventcatalog directory:

```bash
cd dtos-solution-architecture/eventcatalog/nhse-screening-catalog
```

2. Install dependencies:

```bash
npm install
```

#### Running the Event Catalog

1. Start the development server:

```bash
npm run dev
```

2. Open your browser and navigate to http://localhost:3000

The Event Catalog will show all documented events in the system, organized by domain. You can:

- Browse events by domain
- View event schemas
- Search for specific events
- View event relationships and dependencies

## Making Changes

### Architecture Model Changes

The architecture model is defined in the `workspace.dsl` file using a domain-specific language. Reference documentation can be found at [https://docs.structurizr.com/dsl/language](https://docs.structurizr.com/dsl/language).

The model follows a hierarchy:

- SystemContext (top-level)
- Containers
- Components
- Code

Best practices:

- Always document down to the Container level
- Document to Component level only when necessary
- Make changes on a branch and create a Pull Request
- DO NOT merge directly into main
- Changes will automatically update referenced images in Confluence

### Event Catalog Changes

How to make changes to the eventcatalog is covered very explicitly in the docuemntation provided by eventcatalog itself. This can be found here - https://www.eventcatalog.dev/docs/guides

## Development Workflow

1. Create a new branch for your changes
2. Make your modifications
3. Create a Pull Request
4. Wait for review and approval
5. Merge only after approval

Remember: Never merge directly into the main branch. All changes must go through the Pull Request process.

### Create new branch and push to GitHub (using "json-formatting" as an example)

- git status # to see what has changed
- git checkout -b json-formatting # create a branch (eg json-formatting)
- git add . # add the changed files to the list to push to Github
- git commit -m "Addition of new json-formatting" # commit the changed files with message
- git push --set-upstream origin json-formatting # push the changed files to GitHub

Create a pull request for 'json-formatting' on GitHub by visiting: 

https://github.com/NHSDigital/dtos-solution-architecture/pull/new/json-formatting

