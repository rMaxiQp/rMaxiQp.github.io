---
layout: post
title:  "Advanced Message Queuing Protocol Features"
date:   2020-06-07
edit:   2020-06-07
categories: [Network, Web, Protocol, Note]
tags: [Network, Web]
author: Q
---

The Advanced Message Queuing Protocol (AMQP) is an open standard protocol for passing business messages between applications or organizations.

AMQP connects across:

- Organizations
- Platforms
- Time
- Space

AMQP has following features:

- Ubiquity
  - Easy to (a) use, (b) implement, and (c) extend
  - Clear and unambiguous core functionality for business message routing and delivery within Internet infrastructure
  - Low barrier to understand, use and implement

- Safety
  - Infrastructure for a secure and trusted global transaction network
    - Tamper proof business messages
    - Independent durable message for connected receivers
    - Resilient message delivery for technical failure
  - Supports financial transactions of business requirements
  - Impossible for spam injection

- Fidelity
  - Well-stated message queuing and delivery semantics covering
  - Well-stated ordering semantics always having a sender and an observer
  - Well-stated reliable exception handling

- Unity
  - Any AMQP client can initiate communication to any AMQP broker over TCP/IP
  - Provides the core set of messaging patterns
    - Asynchronous directed messaging
    - Request/reply
    - Publish/subscribe
    - Store
    - Forward
  - Negotiable transport protocols (e.g. SCTP, UDP/Multicast) with any AMQP broker
  - Supports
    - Hub & Spoke messaging topology
    - Hub-to-Hub messaging
    - Peer-to-Peer messaging

- Interoperability
  - Multiple stable and interpolating broker implementations
  - Stable core (client-broker) wire protocol
  - Layered architecture
  - Backward compatibility

- Manageability
  - Binary WIRE protocol to be ubiquitous, fast and embedded
  - Scalable
  - Global addressing standardizing end-to-end delivery
  - Decentralized
  - Supports routing and relay management

References:

- <http://www.amqp.org/about/what>
- <http://www.amqp.org/product/features>
