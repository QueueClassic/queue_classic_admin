require 'queue_classic'
QC.default_conn_adapter = QC::ConnAdapter.new(active_record_connection_share: true)
