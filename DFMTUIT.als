module DFMTUIT

// Alec Brinker and Justin Milliman

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

// All replies in a chain are on the same ticket
fact ReplySameTicket { all r: Reply { r.ticket = r.prev.ticket || no r.prev } }

// No reply can be a descendent of itself
fact NoCircularReply { all r: Reply { r not in r.descs }}

// All replies on ticket are from people associated with that ticket
fact AllRepliesFromAssoc { all r: Reply { r.creator in r.ticket.assoc }}

// Four Functions
	// List of people associated with given ticket
fun assoc[t: Ticket]: univ {
	t.customer + t.specialist
}
	// condense r.^@prev?
fun descs[r: Reply]: univ {
	r.^@prev
}
	//

	//

// Four Assertions
	//
	//
	//
	//

// Four Static Predicates
	// Ticket has reply with no prev or no replies
pred tickRoot[t: Ticket] {
	some x: Reply | (x in t.replies && no x.prev) || no t.replies
}
	// Reply has descendant with no prev
pred descsRoot[r: Reply] {
	some x: Reply |  x in r.descs && no x.prev
}
	// Reply's prev's creator associated with same ticket
pred prevAssoc[r: Reply] {
	r.prev.creator in r.ticket.assoc || no r.prev
}
	//

// Four Dynamic Predicates
	//
	//
	//
	//

pred show {}

run prevAssoc for 8
