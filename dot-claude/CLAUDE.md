# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Honesty

- I wish you to be honest with me. If you don't know something, I want you to tell me so.
- If possible, extract exact quotes from your sources and list them. If you can't find relevant quotes, state "No relevant quotes found."

## Grammar rules

- Always end sentences with a period (.), even in tables.
- When producing german documents, always use double s (ss) instead of ß, as this is the convention in Switzerland.
- When writing english, use british english.

## Custom Skills

A custom `/cat` skill is defined in `skills/CAT/SKILL.md`. Invoke it via `/cat <branch-name>` to perform a CAT (Code, Acceptance Criteria, Tests) review on a pull request. It fetches the branch diff from `origin/main` and walks through a structured review checklist.

## Glossary

The glossary contains often used terms and abbreviations. This is rendered as a markdown table.

| Term                       | Abbreviation | Description                                                                                                                                                                                                                                |
| +===                       | +=========== | +==========                                                                                                                                                                                                                                |
| For Implementation Concept |              | This is a document that functions as a guide for creating and writing user stories. It contains a architectural overview of an initiative.                                                                                                 |
| Mitarbeiter                | MA           | Employee, most often in our warehouses                                                                                                                                                                                                     |
| Nicht in Ordnung           | NIO          | English "Not In Order", which are specific work places and processes dealing with articles that have some kind of problem.                                                                                                                 |
| Logistics Operation Area   | LOPS         | The area in PD dealing with processes in our logistics warehouses.                                                                                                                                                                         |
| Product Development        | PD           | The part of the company that deals with developing new software products and maintaining current ones. Split into different areas.                                                                                                         |
| Product Manager/Owner      | PM/PO        | The Product Manager or Product Owner is responsible for managing timelines, resource allocation and the organisation of timelines in a team and for their respective products.                                                             |
| Lot                        |              | Lot represents a grouping of articles of the same product. Once registered and applied, it is immutable. It carries data that may change between the instances of the same product, e.g. an expiration date or the supplied power adapter. |

## File Conventions

- `.md` files: Architectural notes, documentation and planning documents (mix of German and English)
- `.excalidraw` / `.excalidraw.svg` / `.svg`: Architecture diagrams
- `skills/`: Claude Code custom skill definitions

## Formatting

### General

- Always prefer spaces over tabs when indenting.
- Unless otherwise specified, use 2 spaces to indent

### Markdown

These are the specific rules for formatting my markdown files:

- Never split headings with a horizontal rule (`---`).
- Tables should be formated, so that each pipe (|) is in the same column
- Indented list should use 4 spaces

## Python

- Use 4 spaces to indent

## Language

Notes are written in a mix of German and English. Match the language of the document you are editing.
