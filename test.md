# Test

- Put your documentation here! Your text is rendered with [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown).
-


Click the "Edit Source" button above to make changes.
# Alerts

## General Philosophy

*This is a work in progress, and subject to change. Contributions welcomed and appreciated!*

Currently, we use Looks as the primary mechanism for detecting and alerting issues in transformed data presented in Starboard and Snowflake. Typically, these alerts are managed through [schedules](https://docs.looker.com/sharing-and-publishing/scheduling-and-sharing/scheduling), which give us flexibility and low overhead to create an alert.

## Setup

The process for creating an alert is relatively 1:1 with the process for creating and scheduling a Look. One common pattern is to create a Look which filters to only show anomalies or otherwise problematic records, and then schedule the Look to send only when there are results.

Some other things to keep in mind:

- **Consider Alert Noise**: you can control how frequently a Look gets scheduled; especially if the alert is more advisory in nature, make sure you're not swamping our alert channels with redundant information

- **Use Descriptions**: because we're using Looks, it's possible for the alert criteria to get lost in the overall design of the Look. Remember that others may need to review and take action off of alerts you create; use the Look's description field to document the *why* behind the alert (and the *what* if it's not obvious from the Look)

### Destinations

Looker provides a set of endpoints to which it can send Looks. Our current philosophy for sending alerts is:

- **Email PagerDuty**: Use when the alert notifies us of a condition which should result in (relatively) immediate action

- Example: a small but important configuration change happens in an upstream system; Starboard will be incorrect until we update code to correct one or more processes

- **Slack #dse-alerts**: Use when the alert notifies us of anomalies or other important data logic and/or quality issues which should get resolved but aren't immediately actionable

- Example: a process with a known range of valid outputs begins generating unexpected output values; the process should get looked at, but may require review and/or discussion before changes can be made
