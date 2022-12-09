module DFMTUIT

// Alec Brinker and Justin Milliman

// New relation in Person
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

// Make customer/cusTickers and specialist/specTickets symmetric
fact CustomerTicketSymmetric { customer = ~cusTickets }
fact SpecialistTicketSymmetric { specialist = ~specTickets }

// Make ticket/replies and pReplies/creator symmetric
fact ReplyTicketSymmetric { ticket = ~replies }
fact PersonReplySymmetric { pReplies = ~creator}

fact ReplySameTicket { all r: Reply { r.ticket = r.prev.ticket  || no r.prev } }
fact NoSelfReply { all r: Reply { r != r.prev } }

fact NoCircularReply { all r: Reply { r not in r.^@prev }}

pred show {}

run show for 8
