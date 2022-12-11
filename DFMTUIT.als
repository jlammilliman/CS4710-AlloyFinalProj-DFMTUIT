module DFMTUIT

// Alec Brinker and Justin Milliman

// Sigs
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

// Facts
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
	// Set of a person's replies on a given ticket
fun tickReplies[p: Person, t: Ticket]: univ {
	t.replies & p.pReplies
}
	// Inverse of prev
fun next[r: Reply]: univ {
	prev.r
}
	// Generate chain
fun chain[r: Reply]: univ {
	r + r.^prev + ^prev.r
}

// Assertions
	// Set of replies on a ticket equals sum of assoc's sets of replies
assert assocTickRepliesSanity {
	all p: Person, t: Ticket | t.assoc.pReplies = tickReplies[p, t] + tickReplies[t.assoc-p, t]
}
	// R's chain is same as r.prev
assert chainGenSanity {
	all r: Reply | r.chain = r.prev.chain || no r.prev
}
	//
	//

// Static Predicates
	// Ticket has at least one root, i.e., reply with no prev, or no replies
pred tickRoot[t: Ticket] {
	(some x: Reply | (x in t.replies && no x.prev)) || no t.replies
}
	// Reply has descendant with no prev, or is itself a root
pred descsRoot[r: Reply] {
	some x: Reply |  (x in r.descs || x = r) && no x.prev
}
	// Reply has leaf, i.e., reply with no next
pred chainEnds[r: Reply] {
	some x: Reply | (x in ^prev.r || x = r) && no x.next
}
	// Reply's prev's creator associated with same ticket, or reply is root
pred prevAssoc[r: Reply] {
	r.prev.creator in r.ticket.assoc || no r.prev
}

// Dynamic Predicates <- All will require some sort of new ordering module, likely util/time
	// Assign specialist
	// Unassign specialist
	// Post reply?
	// Delete reply? <- This and above would require a new relation/sig to represent 'unposted' replies

// Run multiple
pred show {
	all t: Ticket | t.tickRoot
	all r: Reply | r.descsRoot
	all r: Reply | r.chainEnds
	all r: Reply | r.prevAssoc

	// Dynamic pred(s)
}

run show for 8
