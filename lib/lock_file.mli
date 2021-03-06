(** [Async.Lock_file] is a wrapper that provides async equivalents for
    [Core.Lock_file]. *)

open Import

(** [create ?message path] tries to create a file at [path] containing the text [message],
    pid if none provided.  It returns true on success, false on failure.  Note: there is
    no way to release the lock or the fd created inside!  It will only be released when
    the process dies.*)
val create
  :  ?message:string
  -> ?close_on_exec : bool (* defaults to true *)
  -> ?unlink_on_exit : bool (* defaults to false *)
  -> string
  -> bool Deferred.t

(** [create_exn ?message path] is like [create] except that it throws an exception on
    failure instead of returning a boolean value *)
val create_exn
  :  ?message:string
  -> ?close_on_exec : bool (* defaults to true *)
  -> ?unlink_on_exit : bool (* defaults to false *)
  -> string
  -> unit Deferred.t

(** [wait_create ~path ~message] becomes determined when the file at [path] gets locked.
    Equivalent to [Core.Std.Lock_file.blocking_create]. *)
val waiting_create
  :  ?message:string
  -> ?close_on_exec : bool (* defaults to true *)
  -> ?unlink_on_exit : bool (* defaults to false *)
  -> string
  -> unit Deferred.t

(** [is_locked path] returns true when the file at [path] exists and is locked, false
    otherwise. *)
val is_locked : string -> bool Deferred.t
