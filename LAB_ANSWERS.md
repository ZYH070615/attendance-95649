# Render Attendance Lab Answers

## 1 Service path

Final service path:

`https://attend95649.onrender.com/`

Local verification completed successfully with Java 11 and Tomcat 9. The deployed Render service was then verified at the public URL:

- The submission page returned HTTP 200.
- A valid Student Id and Seat Id pair was recorded.
- An empty Student Id returned `Student Id can not be blank`.
- The Attendee List displayed test IDs in the order `001`, `002`, `003`.

The Render deployment uses Docker, Java 11, and Tomcat 9.

## 2 Problems an instructor may encounter in a real classroom

The service is suitable as a small demonstration, but an instructor could encounter several practical problems:

1. **Attendance data can disappear.** The records are stored in a static in-memory `HashMap`. A Render restart, redeploy, crash, or container replacement clears the entire list.
2. **Students can sign in for other people.** The service does not authenticate users or verify ownership of a Student Id.
3. **A record can be overwritten.** Submitting the same Student Id again replaces its previous Seat Id, with no history showing who changed it or when.
4. **There is no class-session separation.** Records from different lessons, dates, or sections would be mixed until the application restarts.
5. **Input validation is weak.** Seat Id may be blank, malformed, or duplicated, and Student Id format is not checked.
6. **The attendee list is public.** Anyone who knows the URL can view the Student Id and Seat Id pairs, which creates privacy concerns.
7. **The service has no instructor controls.** There is no protected page to open or close attendance, remove incorrect entries, export results, or lock the list.
8. **Free hosting may respond slowly after inactivity.** If the service sleeps when idle, the first request during class can take longer or time out.
9. **Network problems affect attendance.** Classroom Wi-Fi congestion, mobile signal problems, DNS issues, or Render outages can prevent submissions.
10. **There is no reliable audit trail.** The application does not record timestamps, client identity, changes, or failed attempts, so disputes are difficult to resolve.
11. **Concurrent use has scaling limitations.** Synchronization protects this single map inside one process, but multiple application instances would not share the same data.
12. **The output is not safely escaped.** User input is printed into HTML, so malicious HTML or scripts could be inserted unless output encoding is added.

A real attendance service should use authenticated users, a persistent database, per-class sessions, validation, timestamps, role-based access, an audit log, and server-side HTML escaping.

## 3 Code change required to sort by Student Id

The modification belongs in the `studentId == null` branch of `Attend.java`, where the Attendee List is generated. The original code iterates directly over `sid2seat.entrySet()`. Because `sid2seat` is a `HashMap`, that iteration order is not sorted.

The implemented solution copies the keys, sorts them, and then prints the matching values:

```java
List<String> studentIds = new ArrayList<String>(sid2seat.keySet());
Collections.sort(studentIds);
for (String id : studentIds) {
    out.println(id + " : " + sid2seat.get(id) + "<br>");
}
```

The file also imports `ArrayList`, `Collections`, and `List`. This performs ascending lexicographic sorting, which is appropriate when Student Id values use a consistent fixed-width format.
