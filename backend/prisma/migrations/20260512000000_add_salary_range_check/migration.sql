-- Add salary range CHECK constraint (idempotent)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'Position_salary_range_chk'
    ) THEN
        ALTER TABLE "Position"
        ADD CONSTRAINT "Position_salary_range_chk"
        CHECK ("salaryMin" IS NULL OR "salaryMax" IS NULL OR "salaryMin" <= "salaryMax");
    END IF;
END $$;