module DFMTUIT

abstract sig Person {}
some sig Ticket {
	customer: one Customer,
	specialist: lone Specialist,
	replies: set Reply
}
some sig Customer extends Person {
	cusTickets: set Ticket
}
some sig Specialist extends Person {
	specTickets: set Ticket
}
some sig Reply {
	ticket: one Ticket,
	creator: one Person,
	prev: lone Reply
}

fact CustomerTicketReflexive { customer in ~cusTickets }
fact SpecialistTicketReflexive { specialist in ~specTickets }
fact ReplySameTicket { all r: Reply { r.ticket = r.prev.ticket } }
fact NoSelfReply { all r: Reply { r.prev != r } }
//fact NoCircularReply { all r: Reply {r not in ^prev } }
