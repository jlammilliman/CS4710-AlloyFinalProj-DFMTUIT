# Defnitely Not Michigan Technological University's IT Ticket Managemnet System (DFMTUIT)

Here we simulate a ticket management system. The premise is that customers will place tickets, tickets will have certain attributes such as attachments, status, etc., and are updated and managed by a monitoring team.

This system would theoretically be used with another system, such as a piece of software. The users of the ticketing system would be the end users of that other system. As they use it and notice issues, users can create tickets to notify the service team of these issues. When a ticket is created, the user records certain information about the incident: a description of what went wrong and how to duplicate it which may include attachments, and a perceived urgency. A ticket is then created with an unassigned status (placed in a pool for the Service team to pick up). 

Once a ticket has been created, it becomes visible to the service team. Service team members may claim the ticket, which indicates to other service team members and the user that it is being worked on. The service team member may make comments on the ticket; these comments are visible to the user who created the ticket. When the ticket is resolved, the service team member may close it, either by marking it as fixed, or by discarding the ticket (in case a user reports a bug that cannot be replicated, or is not actually a bug at all). The creating user is notified when this occurs. 

When a ticket is closed, it is archived. Archived tickets can be viewed, but cannot be edited or commented on. Tickets cannot be unarchived; a new ticket must be created if the same issue is found again.

# Specification:

## Users can interact with the ticket service in the following ways:
- Create tickets
- Add comments on their tickets, reply to existing comments, and edit their comments
- See replies/comments on their tickets
- See the status of their tickets, from unclaimed to in progress to completeSee who is working on the ticket
- Notified when their tickets are resolved

## Tickets have certain attributes:
- Title, description, urgency, attachments, status

## A Service team exists to respond to tickets:
- See all unclaimed tickets and claim them, changing the status to in progress
- Close tickets, changing the status to complete and archiving the ticket so it can no longer be edited
- Comment on tickets, reply to comments on tickets, and edit their own comments


## What does it not do?
- Users cannot assign tickets to Service team members
- Users cannot edit Service team comments made on tickets
- Users cannot edit the status of a ticket
- Users cannot edit the urgency of a ticket
- Tickets cannot automatically update themselves
- Tickets are not automatically assigned to Service team members
- Service team members cannot edit User comments made on tickets
- Once a ticket is resolved by a service team member, and in the archive, the ticket is not editable
- Once a ticket is archived by a service team member, it cannot be reopened
- Ticket attachments cannot be anything other than a specified accepted file type (only accepts .pdf, .jpeg, .png, and bars things like .exe, .tar etc.)
