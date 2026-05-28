-- Day 10 backfill — surface a "Project" chip on pre-Day-9 tasks.
--
-- WHY: Day-8 tasks carry the old single `folder_link` (the "one folder per task"
-- URL). Day 9 switched to four columns; renderLinkChips() reads
-- `project_folder_link` for the Project chip. Old tasks have folder_link set but
-- project_folder_link NULL, so they show no chips at all.
--
-- WHAT: copy folder_link -> project_folder_link where the new column is empty.
-- Both are project-folder share URLs, so this is a clean, same-meaning copy.
--
-- SAFE: only fills NULL/empty values; never overwrites a real Day-9 link.
-- Non-destructive; re-runnable (idempotent).

-- 1) Preview how many rows will be touched BEFORE running the update:
-- SELECT count(*) AS will_backfill
-- FROM tasks
-- WHERE (project_folder_link IS NULL OR project_folder_link = '')
--   AND folder_link IS NOT NULL
--   AND folder_link <> '';

-- 2) The backfill:
UPDATE tasks
SET project_folder_link = folder_link
WHERE (project_folder_link IS NULL OR project_folder_link = '')
  AND folder_link IS NOT NULL
  AND folder_link <> '';

-- 3) Verify after running:
-- SELECT count(*) AS still_missing_project_link
-- FROM tasks
-- WHERE (project_folder_link IS NULL OR project_folder_link = '');
--
-- NOTE: tasks created before Day 8 (no folder_link at all) genuinely have no
-- folder recorded anywhere — they will still show only the "+" button. That is
-- expected; use the manual "+" to add a link for those if needed.
