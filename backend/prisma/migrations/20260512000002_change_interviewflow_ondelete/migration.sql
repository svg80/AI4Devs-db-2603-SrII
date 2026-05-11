-- Change Position.interviewFlowId referential action from SET NULL to RESTRICT
ALTER TABLE "Position" DROP CONSTRAINT IF EXISTS "Position_interviewFlowId_fkey";

ALTER TABLE "Position" ADD CONSTRAINT "Position_interviewFlowId_fkey"
FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE RESTRICT ON UPDATE CASCADE;