-- Configure replica to connect to primary
SELECT pg_create_physical_replication_slot('replica_slot');

-- Note: Actual replication setup requires triggering from primary
