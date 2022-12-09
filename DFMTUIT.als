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
fact NoCircularReply { all r: Reply { r not in r.^@prev }}

// Four Functions
	// condense r.prev?
	//
	//
	//

// Four Assertions
	//
	//
	//
	//

// Four Static Predicates
	// Ticket has reply with no prev
	// Reply has descendant with no prev
	// 
	//

// Four Dynamic Predicates
	//
	//
	//
	//

pred show {}

run show for 8
