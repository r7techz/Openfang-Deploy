# OpenFang Render Deployment

This repository deploys OpenFang using Docker.

It automatically clones the OpenFang source and builds the specified version.

This repository exists so you do not need to fork the official OpenFang repository.

Instead, you can control the deployed version from this repo.

---

## Deployment (Render)

1. Create a new **Web Service** on Render.

2. Connect this repository.

3. Set environment variables:

OPENAI_API_KEY
ANTHROPIC_API_KEY
GROQ_API_KEY

4. Render will automatically detect the Dockerfile and build the service.

---

## Access

Once deployed:

http://your-render-url:4200

---

## Updating OpenFang Version

To update OpenFang change this line in the Dockerfile:

git checkout v0.3.24

Example:

git checkout v0.3.30

Then push the change and Render will rebuild automatically.

---

## Data Storage

Runtime data is stored in:

/data

This includes:

config.toml
memory.db
workspace

---

## Adding Skills

Skills are stored inside the agents directory.

Example:

/opt/openfang/agents/my_skill/

Create:

SKILL.md

Example content:

# Research Skill

This skill allows the agent to perform deep research tasks.

Restart the service after adding the skill.

---

## Adding Hands (Agents)

Hands are autonomous agents.

Create a folder:

/opt/openfang/agents/my_agent/

Add:

HAND.toml

Example:

name = "research_agent"
description = "Agent that performs research"

model = "google/gemini-2.5-pro"

skills = ["research"]

loop = true

Restart OpenFang after adding the hand.

---

## Logs

docker logs container_name
