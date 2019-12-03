# README

I've originally built this app in order to support my daughter with her hard work in preparation for Spelling Bee competition. I'm convinced that the app contributed in the process of structuring her knowledge and subsequently made her feel a bit more confident and a tiny bit less agitated.

Even though it was much fun for both of us (for her – making product requirements, in my case – resolving real customer requests) I barely see her mastering new words in this app again. So I'm leaving this note here in a hope that somebody else will find our product helpful.

# TODO

## POC

- [x] Prevent autosuggestion
- [x] Autoplay once page loaded
- [x] Have a profile page with a list of success/fail attempts
- [x] Upload to Heroku
- [x] Autofocus on the input
- [x] Group attempts by date / word
- [x] Words proficiency logging
- [x] Catch turbolinks loading event
- [x] Remove whitespaces from the input and don't let to send until filled
- [x] Words proficiency selection (rename controller to Proficiency?)
- [x] Make UX a bit nicer
- [x] Pronounce words letter by letter after submission
- [x] Show definitions
- [x] Pick less often used words first
- [x] A bit of refactoring for word scopes
- [x] Show attempts log per word (feels to be more valuable rather than general log)
- [x] More readable attempts feedback
- [x] Be able to pronounce each word on the proficiency log page
- [x] Change proficiency level immediately in the menu
- [x] Make sure definitions API returns something, add some caching level
- [x] Update proficciency level automatically ocne list exceeded
- [x] Simple landing
- [ ] Anonymous usage
- [ ] Satisfying sound when answers correct
- [ ] Be able to select voice/speed


## NICE TO HAVE IN PUBLIC

- [ ] Google auth (be able to save anonymous usage progress)
- [ ] Words to lists association should be many to many
- [ ] CSV upload
