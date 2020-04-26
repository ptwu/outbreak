(** [object_phrase] is the object phrase that can be part of a player command.  
    Each element of the list represents a word of the object phrase, where a 
    {i word} is defined as a consecutive sequence of non-space characters.
    No element of the list should contain any leading, internal, or 
    trailing spaces.  The list is in the same order as the words in the 
    original command.

    An [object_phrase] cannot be the empty list. *)
type object_phrase = string list

(** [command] is a player command that is decomposed into a verb and possibly 
    an object phrase. *)
type command = 
  | Quit
  | Upgrades
  | Buy of object_phrase
  | Progress
  | Step of int
  | Cure

(** Raised when an empty command is parsed. *)
exception Empty

(** Raised when a malformed command is encountered. *)
exception Malformed

(** [parse str] parses input into a [command]. The first word of [str] becomes 
    the verb. The rest of the words, if any, become the object phrase.

    Requires: [str] contains only alphanumeric (A-Z, a-z, 0-9) and space 
    characters (only ASCII character code 32; not tabs or newlines, etc.).

    Raises: [Empty] if [str] is the empty string or contains only spaces. 

    Raises: [Malformed] if the command is malformed. A command
    is {i malformed} if the verb is neither "upgrades", "buy", "progress", nor 
    "cure" or if the verb is "quit" and there is a non-empty object phrase,
    or if the verb is "go" and there is an empty object phrase.*)
val parse : string -> command

(** [build_phrase lst] is the string represented by [lst] *)
val build_phrase : object_phrase -> string