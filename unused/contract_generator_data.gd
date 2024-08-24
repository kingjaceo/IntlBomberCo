class_name ContractGeneratorDataDEPRECATED
extends Resource

@export var contract_pool: Array[Objective]
@export var contract_templates: Array[ContractTemplate]
var contracts_generated_by_type: Dictionary = {"aid": 0, "destruction": 0, "story": 0}
var contracts_completed_by_type: Dictionary = {"aid": 0, "destruction": 0, "story": 0}
var progress_level: int = 0
