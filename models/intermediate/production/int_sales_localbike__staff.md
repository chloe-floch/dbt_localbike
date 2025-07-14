{% docs int_sales_localbike__staff %}

This model adjusts staff hierarchy inconsistencies.
It ensures that each staff member is linked to an active manager in the same store when needed.

### Key Fields:
- **staff_id**: Primary Key — unique staff identifier.
- **manager_id_corrected**: Corrected manager ID.
- **hierarchy_issue_flag**: Flag indicating a detected issue in the reporting structure.

{% enddocs %}
