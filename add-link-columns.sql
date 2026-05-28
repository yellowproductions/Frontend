-- ============================================================
-- Day 9 — Three-link folder model + parent project folder.
--
-- Adds 4 columns mapping to the new Dropbox structure:
--
--   /[Client]/[Project name]/
--     ├── Doc/        (briefs, refs, strategy — uploaded by SPOC)
--     ├── Creative/   (approved finals — promoted from /REVIEW/)
--     └── Open/       (PSD/AI sources — uploaded by designer)
--
-- doc_link, creative_link, open_link → individual sub-folder URLs
-- project_folder_link → parent folder URL (used on client portal)
--
-- creative_link points at /REVIEW/[Project]/ while in flight,
-- gets overwritten to /[Client]/[Project]/Creative/ on client approval.
--
-- folder_link (added Day 8) is LEFT IN PLACE for now — old reads of it
-- will silently return null on new tasks. Drop it in a follow-up after
-- all four HTMLs are fully migrated.
-- ============================================================

ALTER TABLE tasks
  ADD COLUMN IF NOT EXISTS doc_link            TEXT,
  ADD COLUMN IF NOT EXISTS creative_link       TEXT,
  ADD COLUMN IF NOT EXISTS open_link           TEXT,
  ADD COLUMN IF NOT EXISTS project_folder_link TEXT;

-- Follow-up (run after all HTMLs deployed and verified):
-- ALTER TABLE tasks DROP COLUMN IF EXISTS folder_link;

