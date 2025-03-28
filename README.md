# DToS Solution Architecture Diagrams

## Introduction

This repository stores the solution architecture model for DToS using the DSL Structurizr. The images generated by the structurizr application will be referenced within Confluence for the wider team to be able to see.

## Getting Structurizr Running

Like all repositories, download the source repository to your local machine. You will then need to run Structurizr Lite in order to change and update the model. To do this requires the installation of Docker

Docker can be installed from this location - https://www.docker.com/get-started/ Follow the website instructions to install. 

Once installed, you will need to run the following commands from within your local git repo.

This pulls down the latest Structurizr lite image   
```docker pull structurizr/lite```

The commands (slight variation between MacOS and Windows) below actually runs the container pointing at the files in the directory you're running from.  Once the container is running, it will allow you to access the live view of the model in your local browser by navigating to http://localhost:8080

### MacOS and Linux

```docker run -it --rm -p 8080:8080 -v ./:/usr/local/structurizr structurizr/lite```

Since the macos update to Sequoia 15.2 this docker command was causing a sigterm exception, this can be fixed by running the following command line instead

```docker run --rm -e JAVA_TOOL_OPTIONS="-XX:UseSVE=0" -p 8080:8080 -v ./:/usr/local/structurizr structurizr/lite```

### Windows

```docker run -it --rm -p 8080:8080 -v %cd%:/usr/local/structurizr structurizr/lite```

## Making model changes

The model is defined within the workspace.dsl file. It is a fairly simple domain language, the reference of which exists here - https://docs.structurizr.com/dsl/language

It basically operates on a hierarchy where we have a top-level SystemContext, followed then by Containers, Components and Code. The expectation is to definitely go do to the Container level, but to only go to Component level if it makes sense to do so. 

Changes should be made on branch and a Pull Request created. This will trigger a github action to generate a set of images which get picked up by confluence. DO NOT MERGE DIRECTLY INTO MAIN

If you have updated an existing definition, it should mean because the images are referenced in Confluence, they automatically get updated. 

