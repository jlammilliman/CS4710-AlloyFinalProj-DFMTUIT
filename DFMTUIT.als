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
	// Set of people associated with given ticket
fun assoc[t: Ticket]: univ {
	t.customer + t.specialist
}
	// Condense r.^prev for ease of reading
fun descs[r: Reply]: univ {
	r.^prev
}
	// Set of a person's replies on a given ticket?
fun tickReplies[p: Person, t: Ticket]: univ {
	t.replies & p.pReplies
}
	// 

// Four Assertions
	// Set of replies on a ticket equals sum of assoc's sets of replies
assert assocTickRepliesSanity {
	all p: Person, t: Ticket | t.assoc.pReplies = tickReplies[p, t] + tickReplies[t.assoc-p, t]
}
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
	some x: Reply |  (x in r.descs || x = r) && no x.prev
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

run descsRoot for 8
