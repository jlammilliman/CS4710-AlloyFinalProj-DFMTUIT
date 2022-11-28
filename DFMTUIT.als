module DFMTUIT

abstract sig Person {
	pReplies: set Reply
}
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

fact CustomerTicketReflexive { customer = ~cusTickets }
fact SpecialistTicketReflexive { specialist = ~specTickets }
fact ReplyTicketReflexive { ticket = ~replies }
fact PersonReplyRelexive { pReplies = ~creator}
fact ReplySameTicket { all r: Reply { r.ticket = r.prev.ticket } }
fact NoSelfReply { all r: Reply { r.prev != r } }

pred NoCircularReply[r: Reply] { no r & Reply }
