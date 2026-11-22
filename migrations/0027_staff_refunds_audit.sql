CREATE TABLE IF NOT EXISTS staff_members (
  user_id INTEGER PRIMARY KEY,
  display_name TEXT NOT NULL DEFAULT '',
  permissions_json TEXT NOT NULL DEFAULT '{}',
  active INTEGER NOT NULL DEFAULT 1,
  created_by INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS staff_active ON staff_members(active,user_id);
CREATE TABLE IF NOT EXISTS admin_audit_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  actor_id INTEGER NOT NULL,
  action TEXT NOT NULL,
  target_type TEXT,
  target_id TEXT,
  details_json TEXT NOT NULL DEFAULT '{}',
  created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS admin_audit_actor ON admin_audit_logs(actor_id,created_at DESC);
CREATE INDEX IF NOT EXISTS admin_audit_target ON admin_audit_logs(target_type,target_id,created_at DESC);
CREATE TABLE IF NOT EXISTS refund_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  order_id INTEGER,
  payment_id INTEGER,
  amount_inr REAL,
  reason TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','approved','rejected','cancelled')),
  reviewed_by INTEGER,
  reviewed_at INTEGER,
  admin_note TEXT,
  created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS refund_requests_status ON refund_requests(status,created_at DESC);
CREATE INDEX IF NOT EXISTS refund_requests_user ON refund_requests(user_id,created_at DESC);
