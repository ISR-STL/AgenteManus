# ===============================
# MÓDULOS RESTANTES DO AGENTE MANUS DOCKER
# ===============================

# FITNESS MODULE
fitness_module = '''
"""
Módulo Personal Trainer
Especialista em treinos, musculação e condicionamento físico
"""

import asyncio
import json
from typing import Dict, List
from datetime import datetime, timedelta

class PersonalTrainer:
    """Especialista em Personal Trainer e Fitness"""
    
    def __init__(self):
        self.workout_plans = []
        self.client_profiles = {}
    
    async def process_request(self, request: str) -> Dict:
        """Processar pedido de fitness"""
        request_lower = request.lower()
        
        if "treino" in request_lower:
            return await self.create_workout_plan(request)
        elif "musculação" in request_lower or "musculacao" in request_lower:
            return await self.strength_training_plan(request)
        elif "cardio" in request_lower or "aeróbico" in request_lower:
            return await self.cardio_plan(request)
        elif "exercício" in request_lower or "exercicio" in request_lower:
            return await self.exercise_library(request)
        elif "avaliação" in request_lower or "avaliacao" in request_lower:
            return await self.fitness_assessment(request)
        else:
            return await self.general_fitness_advice(request)
    
    async def create_workout_plan(self, request: str) -> Dict:
        """Criar plano de treino personalizado"""
        workout_plan = {
            "plan_name": "Plano Manus Fitness Personalizado",
            "duration": "12 semanas",
            "frequency": "5x por semana",
            "goal": "Hipertrofia e condicionamento",
            "weekly_schedule": {
                "segunda": {
                    "focus": "Peito e Tríceps",
                    "exercises": [
                        {
                            "name": "Supino reto com barra",
                            "sets": 4,
                            "reps": "8-12",
                            "rest": "90s",
                            "tips": "Controle a descida, explosão na subida"
                        },
                        {
                            "name": "Supino inclinado com halteres",
                            "sets": 3,
                            "reps": "10-15",
                            "rest": "75s",
                            "tips": "Foco na parte superior do peitoral"
                        },
                        {
                            "name": "Crucifixo inclinado",
                            "sets": 3,
                            "reps": "12-15",
                            "rest": "60s",
                            "tips": "Movimento amplo, contração no final"
                        },
                        {
                            "name": "Tríceps testa",
                            "sets": 4,
                            "reps": "10-12",
                            "rest": "60s",
                            "tips": "Cotovelos fixos, movimento isolado"
                        },
                        {
                            "name": "Tríceps corda",
                            "sets": 3,
                            "reps": "12-15",
                            "rest": "45s",
                            "tips": "Extensão completa, contração máxima"
                        }
                    ],
                    "warm_up": "10min bike + alongamento dinâmico",
                    "cool_down": "Alongamento estático 10min"
                },
                "terca": {
                    "focus": "Costas e Bíceps",
                    "exercises": [
                        {
                            "name": "Puxada frontal",
                            "sets": 4,
                            "reps": "8-12",
                            "rest": "90s",
                            "tips": "Puxar até o peito, contrair escápulas"
                        },
                        {
                            "name": "Remada curvada",
                            "sets": 4,
                            "reps": "8-12",
                            "rest": "90s",
                            "tips": "Manter coluna neutra, puxar cotovelos"
                        },
                        {
                            "name": "Remada unilateral",
                            "sets": 3,
                            "reps": "10-12 cada lado",
                            "rest": "75s",
                            "tips": "Estabilizar core, movimento controlado"
                        },
                        {
                            "name": "Rosca direta",
                            "sets": 4,
                            "reps": "10-12",
                            "rest": "60s",
                            "tips": "Cotovelos fixos, contração no topo"
                        },
                        {
                            "name": "Rosca martelo",
                            "sets": 3,
                            "reps": "12-15",
                            "rest": "45s",
                            "tips": "Movimento alternado, controle total"
                        }
                    ]
                },
                "quarta": {
                    "focus": "Pernas (Quadríceps e Glúteos)",
                    "exercises": [
                        {
                            "name": "Agachamento livre",
                            "sets": 4,
                            "reps": "8-12",
                            "rest": "2min",
                            "tips": "Descer até 90°, força nos calcanhares"
                        },
                        {
                            "name": "Leg press 45°",
                            "sets": 4,
                            "reps": "12-15",
                            "rest": "90s",
                            "tips": "Amplitude completa, não travar joelhos"
                        },
                        {
                            "name": "Afundo com halteres",
                            "sets": 3,
                            "reps": "12 cada perna",
                            "rest": "75s",
                            "tips": "Passo amplo, descer até 90°"
                        },
                        {
                            "name": "Cadeira extensora",
                            "sets": 3,
                            "reps": "15-20",
                            "rest": "60s",
                            "tips": "Contração máxima no topo"
                        },
                        {
                            "name": "Panturrilha em pé",
                            "sets": 4,
                            "reps": "15-20",
                            "rest": "45s",
                            "tips": "Amplitude máxima, pausa no topo"
                        }
                    ]
                },
                "quinta": {
                    "focus": "Ombros e Trapézio",
                    "exercises": [
                        {
                            "name": "Desenvolvimento militar",
                            "sets": 4,
                            "reps": "8-12",
                            "rest": "90s",
                            "tips": "Core contraído, movimento vertical"
                        },
                        {
                            "name": "Elevação lateral",
                            "sets": 4,
                            "reps": "12-15",
                            "rest": "60s",
                            "tips": "Cotovelos ligeiramente flexionados"
                        },
                        {
                            "name": "Elevação posterior",
                            "sets": 3,
                            "reps": "15-20",
                            "rest": "60s",
                            "tips": "Foco no deltoide posterior"
                        },
                        {
                            "name": "Encolhimento",
                            "sets": 4,
                            "reps": "12-15",
                            "rest": "60s",
                            "tips": "Movimento vertical, sem rotação"
                        }
                    ]
                },
                "sexta": {
                    "focus": "Pernas (Posteriores) e Core",
                    "exercises": [
                        {
                            "name": "Stiff",
                            "sets": 4,
                            "reps": "10-12",
                            "rest": "90s",
                            "tips": "Quadril para trás, pernas semi-flexionadas"
                        },
                        {
                            "name": "Mesa flexora",
                            "sets": 4,
                            "reps": "12-15",
                            "rest": "75s",
                            "tips": "Contração máxima, movimento controlado"
                        },
                        {
                            "name": "Prancha",
                            "sets": 3,
                            "reps": "45-60s",
                            "rest": "60s",
                            "tips": "Corpo alinhado, respiração normal"
                        },
                        {
                            "name": "Abdominal supra",
                            "sets": 3,
                            "reps": "20-25",
                            "rest": "45s",
                            "tips": "Movimento curto, contração no topo"
                        }
                    ]
                }
            },
            "progression": {
                "weeks_1_4": "Adaptação - foco na técnica",
                "weeks_5_8": "Intensificação - aumento de carga",
                "weeks_9_12": "Especialização - técnicas avançadas"
            },
            "nutrition_timing": {
                "pre_workout": "30-60min antes: carboidrato + cafeína",
                "post_workout": "Até 30min após: proteína + carboidrato",
                "hydration": "500ml água 2h antes + 200ml a cada 15min durante"
            }
        }
        
        return {
            "type": "workout_plan",
            "message": "Plano de treino personalizado criado!",
            "plan": workout_plan,
            "equipment_needed": [
                "Barras e halteres",
                "Banco ajustável",
                "Polia alta/baixa",
                "Leg press",
                "Cadeira extensora/flexora"
            ],
            "safety_tips": [
                "Sempre aquecer antes do treino",
                "Manter boa forma em todos os exercícios",
                "Progredir gradualmente nas cargas",
                "Respeitar dias de descanso",
                "Hidratar-se adequadamente"
            ]
        }
    
    async def strength_training_plan(self, request: str) -> Dict:
        """Plano específico de musculação"""
        strength_plan = {
            "program_type": "Força e Hipertrofia",
            "periodization": "Linear",
            "phases": {
                "phase_1": {
                    "name": "Adaptação Anatômica",
                    "duration": "4 semanas",
                    "sets": "2-3",
                    "reps": "12-15",
                    "intensity": "60-70% 1RM",
                    "rest": "60-90s",
                    "focus": "Técnica e adaptação"
                },
                "phase_2": {
                    "name": "Hipertrofia",
                    "duration": "6 semanas", 
                    "sets": "3-4",
                    "reps": "8-12",
                    "intensity": "70-80% 1RM",
                    "rest": "90-120s",
                    "focus": "Volume e crescimento muscular"
                },
                "phase_3": {
                    "name": "Força",
                    "duration": "4 semanas",
                    "sets": "4-5",
                    "reps": "3-6",
                    "intensity": "80-90% 1RM",
                    "rest": "2-3min",
                    "focus": "Força máxima"
                }
            },
            "key_exercises": {
                "compound_movements": [
                    "Agachamento",
                    "Levantamento terra",
                    "Supino",
                    "Desenvolvimento",
                    "Remada"
                ],
                "isolation_exercises": [
                    "Rosca bíceps",
                    "Tríceps",
                    "Elevações laterais",
                    "Panturrilha",
                    "Abdominais"
                ]
            },
            "progression_methods": [
                "Aumento de carga (2.5-5kg)",
                "Aumento de repetições",
                "Redução do tempo de descanso",
                "Aumento de séries",
                "Técnicas intensivas (drop set, rest-pause)"
            ]
        }
        
        return {
            "type": "strength_training",
            "message": "Plano de musculação estruturado criado!",
            "plan": strength_plan,
            "testing_protocol": {
                "1rm_test": "Teste de 1RM a cada 4-6 semanas",
                "body_composition": "Bioimpedância mensal",
                "measurements": "Medidas corporais quinzenais",
                "photos": "Fotos de progresso mensais"
            }
        }
    
    async def cardio_plan(self, request: str) -> Dict:
        """Plano de treinamento cardiovascular"""
        cardio_plan = {
            "program_overview": "Condicionamento Cardiovascular Progressivo",
            "modalities": {
                "hiit": {
                    "name": "HIIT - High Intensity Interval Training",
                    "frequency": "2-3x por semana",
                    "duration": "20-30 minutos",
                    "structure": {
                        "warm_up": "5min intensidade baixa",
                        "work_interval": "30s alta intensidade",
                        "rest_interval": "90s baixa intensidade",
                        "cycles": "8-12 repetições",
                        "cool_down": "5min intensidade baixa"
                    },
                    "benefits": [
                        "Queima calórica elevada",
                        "Melhora VO2 máximo",
                        "Preserva massa muscular",
                        "Eficiência temporal"
                    ]
                },
                "liss": {
                    "name": "LISS - Low Intensity Steady State",
                    "frequency": "3-4x por semana",
                    "duration": "30-60 minutos",
                    "intensity": "60-70% FCmax",
                    "activities": [
                        "Caminhada rápida",
                        "Bike estacionária",
                        "Elíptico",
                        "Natação"
                    ],
                    "benefits": [
                        "Melhora capacidade aeróbica",
                        "Recuperação ativa",
                        "Baixo impacto",
                        "Sustentável longo prazo"
                    ]
                },
                "circuit_training": {
                    "name": "Circuito Funcional",
                    "frequency": "2x por semana",
                    "duration": "25-35 minutos",
                    "structure": {
                        "stations": 6,
                        "work_time": "45s",
                        "rest_time": "15s",
                        "rounds": "3-4",
                        "rest_between_rounds": "2min"
                    },
                    "exercises": [
                        "Burpees",
                        "Mountain climbers",
                        "Jump squats",
                        "Push-ups",
                        "High knees",
                        "Plank jacks"
                    ]
                }
            },
            "weekly_schedule": {
                "beginner": {
                    "monday": "LISS 30min",
                    "wednesday": "Circuit training",
                    "friday": "LISS 30min",
                    "saturday": "Atividade recreativa"
                },
                "intermediate": {
                    "monday": "HIIT 25min",
                    "tuesday": "LISS 40min",
                    "thursday": "Circuit training",
                    "friday": "HIIT 25min",
                    "sunday": "LISS 45min"
                },
                "advanced": {
                    "monday": "HIIT 30min",
                    "tuesday": "LISS 50min",
                    "wednesday": "Circuit training",
                    "thursday": "HIIT 30min",
                    "friday": "LISS 60min",
                    "saturday": "Atividade esportiva"
                }
            }
        }
        
        return {
            "type": "cardio_plan",
            "message": "Plano de condicionamento cardiovascular criado!",
            "plan": cardio_plan,
            "heart_rate_zones": {
                "zone_1": "50-60% FCmax - Recuperação",
                "zone_2": "60-70% FCmax - Aeróbico base",
                "zone_3": "70-80% FCmax - Aeróbico",
                "zone_4": "80-90% FCmax - Limiar",
                "zone_5": "90-100% FCmax - Neuromuscular"
            },
            "monitoring_tools": [
                "Monitor cardíaco",
                "Apps de corrida (Strava, Nike Run)",
                "Smartwatch",
                "Escala de percepção de esforço (RPE)"
            ]
        }
    
    async def exercise_library(self, request: str) -> Dict:
        """Biblioteca de exercícios"""
        exercise_library = {
            "chest": [
                {
                    "name": "Supino reto",
                    "muscle_groups": ["Peitoral maior", "Tríceps", "Deltoide anterior"],
                    "equipment": "Barra e banco",
                    "difficulty": "Intermediário",
                    "instructions": [
                        "Deitar no banco com pés firmes no chão",
                        "Pegada na barra ligeiramente maior que largura dos ombros",
                        "Descer barra até tocar o peito",
                        "Empurrar explosivamente para cima",
                        "Manter escápulas retraídas"
                    ],
                    "common_mistakes": [
                        "Arquear excessivamente as costas",
                        "Bater a barra no peito",
                        "Pegada muito aberta ou fechada"
                    ]
                }
            ],
            "back": [
                {
                    "name": "Puxada frontal",
                    "muscle_groups": ["Latíssimo", "Romboides", "Bíceps"],
                    "equipment": "Polia alta",
                    "difficulty": "Iniciante",
                    "instructions": [
                        "Sentar com joelhos fixos",
                        "Pegada pronada, mãos afastadas",
                        "Puxar barra até altura do peito",
                        "Contrair escápulas no final",
                        "Retornar controladamente"
                    ]
                }
            ],
            "legs": [
                {
                    "name": "Agachamento livre",
                    "muscle_groups": ["Quadríceps", "Glúteos", "Core"],
                    "equipment": "Barra",
                    "difficulty": "Avançado",
                    "instructions": [
                        "Barra apoiada no trapézio",
                        "Pés afastados na largura dos ombros",
                        "Descer flexionando quadril e joelhos",
                        "Manter joelhos alinhados com pés",
                        "Subir empurrando o chão"
                    ]
                }
            ]
        }
        
        return {
            "type": "exercise_library",
            "message": "Biblioteca de exercícios disponível!",
            "library": exercise_library,
            "exercise_selection_tips": [
                "Priorizar exercícios compostos",
                "Incluir movimentos em todos os planos",
                "Variar pegadas e ângulos",
                "Progredir do simples para complexo"
            ]
        }
    
    async def fitness_assessment(self, request: str) -> Dict:
        """Avaliação física completa"""
        assessment = {
            "anthropometric_measures": {
                "basic": [
                    "Peso corporal",
                    "Altura",
                    "IMC",
                    "Circunferência da cintura"
                ],
                "detailed": [
                    "Percentual de gordura",
                    "Massa muscular",
                    "Massa óssea",
                    "Taxa metabólica basal"
                ]
            },
            "physical_tests": {
                "cardiovascular": {
                    "test": "Teste de 12 minutos (Cooper)",
                    "protocol": "Correr/caminhar máxima distância em 12min",
                    "classification": {
                        "excellent": "> 2800m (homens), > 2300m (mulheres)",
                        "good": "2400-2800m (homens), 2000-2300m (mulheres)",
                        "average": "2000-2400m (homens), 1600-2000m (mulheres)",
                        "below_average": "< 2000m (homens), < 1600m (mulheres)"
                    }
                },
                "strength": {
                    "upper_body": "Flexões máximas em 1 minuto",
                    "lower_body": "Agachamentos máximos em 1 minuto",
                    "core": "Prancha - tempo máximo"
                },
                "flexibility": {
                    "test": "Sentar e alcançar",
                    "equipment": "Banco de Wells",
                    "measurement": "Distância alcançada em cm"
                }
            },
            "movement_screening": {
                "overhead_squat": "Avalia mobilidade e estabilidade",
                "single_leg_squat": "Avalia força unilateral",
                "shoulder_mobility": "Avalia amplitude articular",
                "trunk_stability": "Avalia controle do core"
            },
            "lifestyle_assessment": {
                "sleep_quality": "Horas e qualidade do sono",
                "stress_level": "Escala de 1-10",
                "activity_level": "Sedentário a muito ativo",
                "nutrition_habits": "Frequência e qualidade alimentar"
            }
        }
        
        return {
            "type": "fitness_assessment",
            "message": "Protocolo de avaliação física completo!",
            "assessment": assessment,
            "recommendations": [
                "Realizar avaliação inicial completa",
                "Repetir testes a cada 4-6 semanas",
                "Documentar progressos com fotos",
                "Ajustar programa baseado nos resultados"
            ]
        }
    
    async def general_fitness_advice(self, request: str) -> Dict:
        """Conselhos gerais de fitness"""
        return {
            "type": "fitness_advice",
            "message": "Conselhos gerais para otimizar seus resultados",
            "principles": [
                "Consistência é mais importante que perfeição",
                "Progressão gradual previne lesões",
                "Recuperação é parte do treinamento",
                "Nutrição representa 70% dos resultados"
            ],
            "beginner_tips": [
                "Comece devagar e aumente gradualmente",
                "Foque na técnica antes da carga",
                "Inclua exercícios de mobilidade",
                "Estabeleça metas realistas"
            ],
            "common_mistakes": [
                "Treinar todos os dias sem descanso",
                "Focar apenas em exercícios que gosta",
                "Negligenciar aquecimento e alongamento",
                "Comparar-se com outros"
            ],
            "motivation_strategies": [
                "Definir metas SMART",
                "Encontrar um parceiro de treino",
                "Variar os exercícios regularmente",
                "Celebrar pequenas vitórias",
                "Manter um diário de treinos"
            ]
        }
'''

# NUTRITION MODULE
nutrition_module = '''
"""
Módulo Nutricionista IA
Especialista em nutrição, dietas e suplementação
"""

import asyncio
import json
from typing import Dict, List
from datetime import datetime

class NutritionistAI:
    """Especialista em Nutrição e Dietética"""
    
    def __init__(self):
        self.meal_plans = []
        self.nutrition_database = {}
    
    async def process_request(self, request: str) -> Dict:
        """Processar pedido de nutrição"""
        request_lower = request.lower()
        
        if "dieta" in request_lower:
            return await self.create_diet_plan(request)
        elif "cardápio" in request_lower or "cardapio" in request_lower:
            return await self.create_meal_plan(request)
        elif "calorias" in request_lower:
            return await self.calculate_calories(request)
        elif "suplemento" in request_lower:
            return await self.supplement_advice(request)
        elif "receita" in request_lower:
            return await self.healthy_recipes(request)
        else:
            return await self.general_nutrition_advice(request)
    
    async def create_diet_plan(self, request: str) -> Dict:
        """Criar plano alimentar personalizado"""
        diet_plan = {
            "plan_name": "Plano Nutricional Manus",
            "objective": "Hipertrofia e composição corporal",
            "duration": "12 semanas",
            "macronutrient_distribution": {
                "protein": "30% (2.2g/kg peso)",
                "carbohydrates": "40% (4-6g/kg peso)",
                "fats": "30% (1g/kg peso)"
            },
            "daily_calories": 2500,
            "meal_timing": {
                "breakfast": {
                    "time": "07:00",
                    "calories": 500,
                    "macros": "P: 25g | C: 60g | G: 15g",
                    "foods": [
                        "2 ovos inteiros + 2 claras",
                        "80g aveia",
                        "1 banana média",
                        "10g pasta de amendoim"
                    ]
                },
                "mid_morning": {
                    "time": "10:00",
                    "calories": 300,
                    "macros": "P: 25g | C: 30g | G: 8g",
                    "foods": [
                        "1 scoop whey protein",
                        "1 maçã média",
                        "10 amêndoas"
                    ]
                },
                "lunch": {
                    "time": "13:00",
                    "calories": 700,
                    "macros": "P: 40g | C: 80g | G: 20g",
                    "foods": [
                        "150g peito de frango",
                        "150g arroz integral",
                        "100g brócolis",
                        "1 colher sopa azeite"
                    ]
                },
                "pre_workout": {
                    "time": "16:00",
                    "calories": 200,
                    "macros": "P: 5g | C: 40g | G: 2g",
                    "foods": [
                        "1 banana",
                        "1 colher mel",
                        "Café preto"
                    ]
                },
                "post_workout": {
                    "time": "18:30",
                    "calories": 350,
                    "macros": "P: 30g | C: 40g | G: 5g",
                    "foods": [
                        "1 scoop whey protein",
                        "300ml leite desnatado",
                        "1 banana"
                    ]
                },
                "dinner": {
                    "time": "20:00",
                    "calories": 450,
                    "macros": "P: 35g | C: 30g | G: 18g",
                    "foods": [
                        "150g salmão",
                        "100g batata doce",
                        "Salada verde",
                        "1 colher sopa azeite"
                    ]
                }
            },
            "hydration": {
                "daily_target": "35ml por kg de peso corporal",
                "timing": [
                    "500ml ao acordar",
                    "200ml antes das refeições",
                    "500ml durante treino",
                    "300ml antes de dormir"
                ]
            },
            "weekly_variations": {
                "carb_cycling": {
                    "high_carb": "Dias de treino intenso (seg, qua, sex)",
                    "moderate_carb": "Dias de treino leve (ter, qui)",
                    "low_carb": "Dias de descanso (sab, dom)"
                }
            }
        }
        
        return {
            "type": "diet_plan",
            "message": "Plano alimentar personalizado criado!",
            "plan": diet_plan,
            "shopping_list": [
                "Proteínas: frango, peixe, ovos, whey",
                "Carboidratos: arroz integral, aveia, batata doce",
                "Gorduras: azeite, castanhas, abacate",
                "Vegetais: brócolis, espinafre, tomate",
                "Frutas: banana, maçã, frutas vermelhas"
            ],
            "meal_prep_tips": [
                "Cozinhar proteínas em lote no domingo",
                "Pré-cortar vegetais para a semana",
                "Preparar porções de carboidratos",
                "Usar recipientes de vidro para armazenar"
            ]
        }
    
    async def create_meal_plan(self, request: str) -> Dict:
        """Criar cardápio semanal"""
        meal_plan = {
            "week_1": {
                "monday": {
                    "breakfast": "Omelete de 3 ovos com espinafre + 2 fatias pão integral",
                    "snack_1": "Iogurte grego com frutas vermelhas",
                    "lunch": "Peito de frango grelhado + quinoa + legumes refogados",
                    "snack_2": "Shake de whey com banana",
                    "dinner": "Salmão assado + aspargos + salada verde"
                },
                "tuesday": {
                    "breakfast": "Smoothie de frutas com aveia e chia",
                    "snack_1": "Mix de castanhas (30g)",
                    "lunch": "Carne magra + arroz integral + feijão + salada",
                    "snack_2": "Queijo cottage com tomate cereja",
                    "dinner": "Peixe grelhado + purê de abóbora + brócolis"
                },
                "wednesday": {
                    "breakfast": "Panqueca de aveia com frutas",
                    "snack_1": "Maçã com pasta de amendoim",
                    "lunch": "Frango desfiado + batata doce + couve refogada",
                    "snack_2": "Vitamina de whey com leite",
                    "dinner": "Omelete de claras + salada de folhas verdes"
                }
            }
        }
        
        return {
            "type": "meal_plan",
            "message": "Cardápio semanal balanceado criado!",
            "plan": meal_plan,
            "nutritional_balance": {
                "variety": "Diferentes fontes de proteína diariamente",
                "colors": "Pelo menos 5 cores diferentes por dia",
                "fiber": "25-35g de fibras diárias",
                "antioxidants": "Frutas e vegetais em todas as refeições"
            }
        }
    
    async def calculate_calories(self, request: str) -> Dict:
        """Calcular necessidades calóricas"""
        # Exemplo para homem, 30 anos, 80kg, 180cm, ativo
        calculations = {
            "bmr_calculation": {
                "formula": "Harris-Benedict revisada",
                "male": "88.362 + (13.397 × peso) + (4.799 × altura) - (5.677 × idade)",
                "female": "447.593 + (9.247 × peso) + (3.098 × altura) - (4.330 × idade)",
                "example_bmr": 1850  # kcal/dia
            },
            "activity_factors": {
                "sedentary": "BMR × 1.2 (pouco ou nenhum exercício)",
                "light": "BMR × 1.375 (exercício leve 1-3 dias/semana)",
                "moderate": "BMR × 1.55 (exercício moderado 3-5 dias/semana)",
                "high": "BMR × 1.725 (exercício intenso 6-7 dias/semana)",
                "extreme": "BMR × 1.9 (exercício muito intenso, trabalho físico)"
            },
            "tdee_example": 2870,  # BMR × 1.55
            "goals": {
                "maintenance": 2870,
                "fat_loss": 2300,  # -20%
                "muscle_gain": 3150,  # +10%
                "aggressive_cut": 2000,  # -30%
                "lean_bulk": 3020   # +5%
            },
            "macronutrient_targets": {
                "fat_loss": {
                    "protein": "40% (230g)",
                    "carbs": "30% (173g)",
                    "fats": "30% (77g)"
                },
                "muscle_gain": {
                    "protein": "30% (236g)",
                    "carbs": "45% (354g)",
                    "fats": "25% (88g)"
                }
            }
        }
        
        return {
            "type": "calorie_calculation",
            "message": "Cálculo de necessidades calóricas realizado!",
            "calculations": calculations,
            "tracking_tips": [
                "Use apps como MyFitnessPal ou FatSecret",
                "Pese os alimentos nas primeiras semanas",
                "Ajuste baseado nos resultados semanais",
                "Monitore peso e medidas corporais"
            ]
        }
    
    async def supplement_advice(self, request: str) -> Dict:
        """Orientações sobre suplementação"""
        supplements = {
            "essential": {
                "whey_protein": {
                    "purpose": "Complementar ingestão proteica",
                    "dosage": "25-30g pós-treino",
                    "timing": "Pós-treino ou entre refeições",
                    "benefits": "Recuperação muscular, praticidade"
                },
                "creatine": {
                    "purpose": "Aumentar força e potência",
                    "dosage": "3-5g diários",
                    "timing": "Qualquer horário, com consistência",
                    "benefits": "Força, potência, volume muscular"
                },
                "vitamin_d3": {
                    "purpose": "Saúde óssea e imunidade",
                    "dosage": "2000-4000 UI/dia",
                    "timing": "Com refeição contendo gordura",
                    "benefits": "Imunidade, saúde óssea, humor"
                },
                "omega_3": {
                    "purpose": "Anti-inflamatório",
                    "dosage": "1-2g EPA+DHA/dia",
                    "timing": "Com refeições",
                    "benefits": "Saúde cardiovascular, recuperação"
                }
            },
            "performance": {
                "caffeine": {
                    "purpose": "Energia e foco",
                    "dosage": "200-400mg",
                    "timing": "30-45min pré-treino",
                    "benefits": "Energia, foco, queima de gordura"
                },
                "beta_alanine": {
                    "purpose": "Resistência muscular",
                    "dosage": "3-5g/dia divididos",
                    "timing": "Com refeições",
                    "benefits": "Resistência, reduz fadiga"
                },
                "citrulline": {
                    "purpose": "Pump e resistência",
                    "dosage": "6-8g",
                    "timing": "30min pré-treino",
                    "benefits": "Vascularização, resistência"
                }
            },
            "health": {
                "multivitamin": {
                    "purpose": "Cobertura nutricional",
                    "dosage": "Conforme rótulo",
                    "timing": "Com primeira refeição",
                    "benefits": "Prevenção de deficiências"
                },
                "probiotics": {
                    "purpose": "Saúde intestinal",
                    "dosage": "10-50 bilhões CFU",
                    "timing": "Estômago vazio",
                    "benefits": "Digestão, imunidade"
                },
                "magnesium": {
                    "purpose": "Relaxamento e sono",
                    "dosage": "200-400mg",
                    "timing": "Antes de dormir",
                    "benefits": "Sono, relaxamento muscular"
                }
            }
        }
        
        return {
            "type": "supplement_advice",
            "message": "Orientações de suplementação personalizadas!",
            "supplements": supplements,
            "priority_order": [
                "1º: Dieta balanceada (sempre primeiro)",
                "2º: Whey protein (se necessário)",
                "3º: Creatina (para treino de força)",
                "4º: Vitamina D3 (se deficiente)",
                "5º: Ômega 3 (se baixo consumo de peixe)"
            ],
            "safety_tips": [
                "Consulte médico antes de iniciar",
                "Compre de marcas confiáveis",
                "Verifique interações medicamentosas",
                "Monitore efeitos colaterais",
                "Não substitua alimentação real"
            ]
        }
    
    async def healthy_recipes(self, request: str) -> Dict:
        """Receitas saudáveis e nutritivas"""
        recipes = {
            "high_protein": {
                "protein_pancakes": {
                    "ingredients": [
                        "2 ovos inteiros",
                        "1 banana madura",
                        "30g aveia em flocos",
                        "1 scoop whey protein",
                        "Canela a gosto"
                    ],
                    "instructions": [
                        "Bater todos os ingredientes no liquidificador",
                        "Aquecer frigideira antiaderente",
                        "Fazer panquecas pequenas",
                        "Virar quando bolhas aparecerem",
                        "Servir com frutas"
                    ],
                    "nutrition": "P: 35g | C: 40g | G: 8g | Cal: 360"
                },
                "chicken_meatballs": {
                    "ingredients": [
                        "500g peito de frango moído",
                        "1 ovo",
                        "2 colheres aveia",
                        "Temperos a gosto",
                        "Cebola picada"
                    ],
                    "instructions": [
                        "Misturar todos os ingredientes",
                        "Formar bolinhas",
                        "Assar a 180°C por 20min",
                        "Virar na metade do tempo"
                    ],
                    "nutrition": "P: 30g | C: 5g | G: 3g | Cal: 170 (por porção)"
                }
            },
            "post_workout": {
                "recovery_smoothie": {
                    "ingredients": [
                        "1 banana",
                        "1 scoop whey protein",
                        "200ml leite desnatado",
                        "1 colher aveia",
                        "Gelo a gosto"
                    ],
                    "instructions": [
                        "Bater todos os ingredientes",
                        "Consumir até 30min pós-treino"
                    ],
                    "nutrition": "P: 35g | C: 45g | G: 2g | Cal: 330"
                }
            },
            "meal_prep": {
                "chicken_rice_bowl": {
                    "ingredients": [
                        "150g peito de frango",
                        "100g arroz integral",
                        "100g brócolis",
                        "50g cenoura",
                        "Temperos naturais"
                    ],
                    "instructions": [
                        "Temperar e grelhar o frango",
                        "Cozinhar arroz integral",
                        "Refogar vegetais no vapor",
                        "Montar bowl e armazenar"
                    ],
                    "nutrition": "P: 35g | C: 50g | G: 8g | Cal: 400",
                    "storage": "Geladeira por até 4 dias"
                }
            }
        }
        
        return {
            "type": "healthy_recipes",
            "message": "Receitas saudáveis e nutritivas!",
            "recipes": recipes,
            "cooking_tips": [
                "Use temperos naturais em vez de sal",
                "Prefira métodos de cocção saudáveis",
                "Prepare em lotes para economizar tempo",
                "Varie cores e texturas",
                "Mantenha sempre vegetais disponíveis"
            ]
        }
    
    async def general_nutrition_advice(self, request: str) -> Dict:
        """Conselhos gerais de nutrição"""
        return {
            "type": "nutrition_advice",
            "message": "Fundamentos da nutrição saudável",
            "basic_principles": [
                "Coma comida de verdade, não produtos",
                "Priorize alimentos integrais",
                "Inclua proteína em todas as refeições",
                "Consuma vegetais variados diariamente",
                "Hidrate-se adequadamente"
            ],
            "portion_control": {
                "protein": "Palma da mão",
                "carbs": "Punho fechado",
                "fats": "Polegar",
                "vegetables": "2 punhos fechados"
            },
            "timing_strategies": [
                "Café da manhã rico em proteína",
                "Carboidratos ao redor do treino",
                "Jantar mais leve",
                "Evitar comer 3h antes de dormir"
            ],
            "common_mistakes": [
                "Pular refeições",
                "Dietas muito restritivas",
                "Não beber água suficiente",
                "Focar apenas em calorias",
                "Eliminar grupos alimentares"
            ]
        }
'''

# OFFICE MODULE
office_module = '''
"""
Módulo Office Automation
Especialista em Excel, Word, PowerPoint e PDF
"""

import asyncio
import json
from typing import Dict, List
from datetime import datetime

class OfficeAutomation:
    """Especialista em Automação Office"""
    
    def __init__(self):
        self.documents = []
        self.templates = {}
    
    async def process_request(self, request: str) -> Dict:
        """Processar pedido de office"""
        request_lower = request.lower()
        
        if "excel" in request_lower or "planilha" in request_lower:
            return await self.excel_automation(request)
        elif "word" in request_lower or "documento" in request_lower:
            return await self.word_automation(request)
        elif "powerpoint" in request_lower or "apresentação" in request_lower:
            return await self.powerpoint_automation(request)
        elif "pdf" in request_lower:
            return await self.pdf_automation(request)
        elif "dashboard" in request_lower:
            return await self.create_dashboard(request)
        else:
            return await self.general_office_advice(request)
    
    async def excel_automation(self, request: str) -> Dict:
        """Automação Excel avançada"""
        excel_solutions = {
            "financial_dashboard": {
                "description": "Dashboard financeiro completo",
                "sheets": [
                    {
                        "name": "Dados",
                        "purpose": "Base de dados brutos",
                        "columns": [
                            "Data", "Categoria", "Descrição", 
                            "Valor", "Tipo", "Status"
                        ]
                    },
                    {
                        "name": "Dashboard",
                        "purpose": "Visualização principal",
                        "components": [
                            "Gráfico de receitas vs despesas",
                            "Evolução mensal",
                            "Top categorias",
                            "Indicadores KPI"
                        ]
                    },
                    {
                        "name": "Relatórios",
                        "purpose": "Análises detalhadas",
                        "reports": [
                            "Fluxo de caixa",
                            "Análise por categoria",
                            "Projeções futuras"
                        ]
                    }
                ],
                "formulas": {
                    "receita_total": "=SUMIF(Dados!E:E,\"Receita\",Dados!D:D)",
                    "despesa_total": "=SUMIF(Dados!E:E,\"Despesa\",Dados!D:D)",
                    "saldo": "=receita_total-despesa_total",
                    "media_mensal": "=AVERAGE(SUMIFS(Dados!D:D,Dados!A:A,\">=\"&DATE(YEAR(TODAY()),MONTH(TODAY()),1)))"
                },
                "charts": [
                    {
                        "type": "Coluna",
                        "data": "Receitas vs Despesas por mês",
                        "position": "B2:H15"
                    },
                    {
                        "type": "Pizza",
                        "data": "Distribuição por categoria",
                        "position": "J2:P15"
                    }
                ],
                "automation": [
                    "Atualização automática de gráficos",
                    "Formatação condicional para alertas",
                    "Validação de dados de entrada",
                    "Macros para relatórios automáticos"
                ]
            },
            "inventory_system": {
                "description": "Sistema de controle de estoque",
                "features": [
                    "Cadastro de produtos",
                    "Controle de entrada/saída",
                    "Alertas de estoque mínimo",
                    "Relatórios de movimentação",
                    "Análise ABC",
                    "Previsão de demanda"
                ],
                "formulas_advanced": [
                    "=INDEX(MATCH()) para busca avançada",
                    "=SUMPRODUCT() para cálculos condicionais",
                    "=OFFSET() para referências dinâmicas",
                    "=INDIRECT() para referências flexíveis"
                ]
            },
            "hr_management": {
                "description": "Gestão de recursos humanos",
                "modules": [
                    "Cadastro de funcionários",
                    "Controle de ponto",
                    "Cálculo de folha de pagamento",
                    "Gestão de férias",
                    "Avaliação de desempenho",
                    "Treinamentos e certificações"
                ]
            }
        }
        
        return {
            "type": "excel_automation",
            "message": "Soluções Excel avançadas disponíveis!",
            "solutions": excel_solutions,
            "vba_examples": {
                "auto_backup": """
Sub AutoBackup()
    Dim backup_path As String
    backup_path = "C:\\Backup\\" & Format(Now, "yyyy-mm-dd_hh-mm") & "_" & ActiveWorkbook.Name
    ActiveWorkbook.SaveCopyAs backup_path
End Sub
                """,
                "data_validation": """
Sub ValidateData()
    Dim ws As Worksheet
    Set ws = ActiveSheet
    
    With ws.Range("A:A").Validation
        .Delete
        .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, _
             Formula1:="Receita,Despesa,Investimento"
    End With
End Sub
                """
            },
            "power_query_tips": [
                "Conectar múltiplas fontes de dados",
                "Transformar dados automaticamente",
                "Atualizar dados com um clique",
                "Combinar tabelas relacionadas"
            ]
        }
    
    async def word_automation(self, request: str) -> Dict:
        """Automação Word avançada"""
        word_solutions = {
            "document_templates": {
                "business_proposal": {
                    "structure": [
                        "Capa com logo e informações",
                        "Sumário executivo",
                        "Análise de necessidades",
                        "Proposta de solução",
                        "Cronograma e investimento",
                        "Termos e condições"
                    ],
                    "automation": [
                        "Campos automáticos para dados",
                        "Numeração automática",
                        "Índice automático",
                        "Referências cruzadas"
                    ]
                },
                "technical_manual": {
                    "features": [
                        "Estrutura hierárquica",
                        "Índice automático",
                        "Lista de figuras",
                        "Glossário",
                        "Referências bibliográficas"
                    ]
                },
                "contract_template": {
                    "elements": [
                        "Cabeçalho padronizado",
                        "Campos de preenchimento",
                        "Cláusulas padrão",
                        "Assinaturas digitais",
                        "Controle de versões"
                    ]
                }
            },
            "mail_merge": {
                "applications": [
                    "Cartas personalizadas",
                    "Etiquetas de endereço",
                    "Certificados em massa",
                    "Contratos personalizados"
                ],
                "data_sources": [
                    "Excel",
                    "Access",
                    "Outlook",
                    "CSV files"
                ]
            },
            "macros_vba": {
                "document_formatting": """
Sub FormatDocument()
    With ActiveDocument.Range.Font
        .Name = "Arial"
        .Size = 12
    End With
    
    With ActiveDocument.Range.ParagraphFormat
        .SpaceAfter = 6
        .LineSpacing = LinesToPoints(1.15)
    End With
End Sub
                """,
                "auto_table_of_contents": """
Sub UpdateTOC()
    Dim toc As TableOfContents
    For Each toc In ActiveDocument.TablesOfContents
        toc.Update
    Next toc
End Sub
                """
            }
        }
        
        return {
            "type": "word_automation",
            "message": "Automação Word implementada!",
            "solutions": word_solutions,
            "best_practices": [
                "Usar estilos consistentes",
                "Implementar campos automáticos",
                "Criar templates reutilizáveis",
                "Automatizar tarefas repetitivas"
            ]
        }
    
    async def powerpoint_automation(self, request: str) -> Dict:
        """Automação PowerPoint"""
        ppt_solutions = {
            "presentation_templates": {
                "business_pitch": {
                    "slides": [
                        "Slide título com logo",
                        "Problema/Oportunidade",
                        "Solução proposta",
                        "Mercado e competição",
                        "Modelo de negócio",
                        "Projeções financeiras",
                        "Equipe",
                        "Próximos passos"
                    ],
                    "design_elements": [
                        "Paleta de cores corporativa",
                        "Fontes padronizadas",
                        "Layouts consistentes",
                        "Ícones e ilustrações"
                    ]
                },
                "training_presentation": {
                    "structure": [
                        "Objetivos de aprendizagem",
                        "Conteúdo modular",
                        "Exercícios práticos",
                        "Avaliação",
                        "Recursos adicionais"
                    ]
                }
            },
            "automation_features": {
                "slide_master": [
                    "Layout padrão",
                    "Formatação automática",
                    "Placeholders dinâmicos",
                    "Numeração automática"
                ],
                "vba_macros": {
                    "bulk_formatting": """
Sub FormatAllSlides()
    Dim slide As Slide
    For Each slide In ActivePresentation.Slides
        With slide.Shapes.Title.TextFrame.TextRange.Font
            .Name = "Arial"
            .Size = 32
            .Bold = True
        End With
    Next slide
End Sub
                    """,
                    "export_slides": """
Sub ExportSlidesToPNG()
    Dim slide As Slide
    Dim i As Integer
    i = 1
    
    For Each slide In ActivePresentation.Slides
        slide.Export "C:\\Export\\Slide_" & i & ".png", "PNG"
        i = i + 1
    Next slide
End Sub
                    """
                }
            },
            "interactive_elements": [
                "Botões de navegação",
                "Hyperlinks internos",
                "Animações sincronizadas",
                "Triggers de ação"
            ]
        }
        
        return {
            "type": "powerpoint_automation",
            "message": "Apresentações automatizadas criadas!",
            "solutions": ppt_solutions,
            "design_tips": [
                "Máximo 6 linhas por slide",
                "Usar imagens de alta qualidade",
                "Manter consistência visual",
                "Testar em diferentes dispositivos"
            ]
        }
    
    async def pdf_automation(self, request: str) -> Dict:
        """Automação PDF"""
        pdf_solutions = {
            "creation": {
                "from_word": "Exportar com marcadores e links",
                "from_excel": "Manter formatação e gráficos",
                "from_powerpoint": "Preservar animações como notas"
            },
            "manipulation": {
                "merge_pdfs": "Combinar múltiplos arquivos",
                "split_pdfs": "Separar por páginas ou seções",
                "extract_pages": "Extrair páginas específicas",
                "add_watermarks": "Marca d'água personalizada"
            },
            "forms": {
                "fillable_forms": [
                    "Campos de texto",
                    "Checkboxes",
                    "Dropdowns",
                    "Assinaturas digitais"
                ],
                "validation": [
                    "Campos obrigatórios",
                    "Formato de dados",
                    "Cálculos automáticos"
                ]
            },
            "security": {
                "password_protection": "Proteger abertura e edição",
                "digital_signatures": "Autenticidade e integridade",
                "permissions": "Controlar impressão e cópia"
            }
        }
        
        return {
            "type": "pdf_automation",
            "message": "Soluções PDF implementadas!",
            "solutions": pdf_solutions,
            "tools_recommended": [
                "Adobe Acrobat Pro",
                "PDFtk",
                "Python PyPDF2",
                "Power Automate"
            ]
        }
    
    async def create_dashboard(self, request: str) -> Dict:
        """Criar dashboard executivo"""
        dashboard = {
            "executive_dashboard": {
                "kpis": [
                    {
                        "name": "Receita Total",
                        "value": "R$ 1.250.000",
                        "change": "+15.3%",
                        "status": "positive"
                    },
                    {
                        "name": "Margem de Lucro",
                        "value": "23.5%",
                        "change": "+2.1%",
                        "status": "positive"
                    },
                    {
                        "name": "Satisfação Cliente",
                        "value": "4.7/5",
                        "change": "+0.3",
                        "status": "positive"
                    },
                    {
                        "name": "Produtividade",
                        "value": "87%",
                        "change": "-1.2%",
                        "status": "attention"
                    }
                ],
                "charts": [
                    {
                        "type": "Linha",
                        "title": "Evolução da Receita",
                        "period": "12 meses",
                        "trend": "Crescimento consistente"
                    },
                    {
                        "type": "Barras",
                        "title": "Vendas por Região",
                        "data": "Comparativo mensal",
                        "insight": "Sudeste lidera com 45%"
                    },
                    {
                        "type": "Pizza",
                        "title": "Canais de Venda",
                        "breakdown": "Online 60%, Físico 40%",
                        "trend": "Crescimento digital"
                    }
                ],
                "alerts": [
                    "Estoque baixo em 3 produtos",
                    "Meta mensal 95% atingida",
                    "2 clientes VIP aniversariando"
                ]
            },
            "automation_features": [
                "Atualização automática de dados",
                "Alertas por email",
                "Exportação programada",
                "Acesso mobile responsivo"
            ]
        }
        
        return {
            "type": "dashboard_creation",
            "message": "Dashboard executivo criado!",
            "dashboard": dashboard,
            "implementation_steps": [
                "Conectar fontes de dados",
                "Configurar KPIs principais",
                "Criar visualizações",
                "Implementar alertas",
                "Testar responsividade"
            ]
        }
    
    async def general_office_advice(self, request: str) -> Dict:
        """Conselhos gerais de produtividade Office"""
        return {
            "type": "office_advice",
            "message": "Dicas de produtividade Office",
            "productivity_tips": [
                "Use atalhos de teclado",
                "Crie templates reutilizáveis",
                "Automatize tarefas repetitivas",
                "Mantenha arquivos organizados",
                "Faça backup regularmente"
            ],
            "keyboard_shortcuts": {
                "universal": [
                    "Ctrl+C: Copiar",
                    "Ctrl+V: Colar",
                    "Ctrl+Z: Desfazer",
                    "Ctrl+S: Salvar",
                    "F12: Salvar como"
                ],
                "excel": [
                    "Ctrl+Shift+L: Filtros",
                    "Alt+=: Soma automática",
                    "F4: Repetir última ação",
                    "Ctrl+T: Criar tabela"
                ]
            },
            "organization_tips": [
                "Use nomenclatura consistente",
                "Crie estrutura de pastas lógica",
                "Versione documentos importantes",
                "Mantenha templates atualizados"
            ]
        }
'''

# AUTOMATION MODULE
automation_module = '''
"""
Módulo Automação Windows
Especialista em automação de tarefas e integração de sistemas
"""

import asyncio
import json
from typing import Dict, List
from datetime import datetime

class WindowsAutomation:
    """Especialista em Automação Windows"""
    
    def __init__(self):
        self.scripts = []
        self.scheduled_tasks = []
    
    async def process_request(self, request: str) -> Dict:
        """Processar pedido de automação"""
        request_lower = request.lower()
        
        if "backup" in request_lower:
            return await self.backup_automation(request)
        elif "script" in request_lower:
            return await self.create_script(request)
        elif "tarefa" in request_lower or "agendamento" in request_lower:
            return await self.task_scheduling(request)
        elif "monitoramento" in request_lower:
            return await self.system_monitoring(request)
        elif "integração" in request_lower or "integracao" in request_lower:
            return await self.system_integration(request)
        else:
            return await self.general_automation_advice(request)
    
    async def backup_automation(self, request: str) -> Dict:
        """Sistema de backup automatizado"""
        backup_system = {
            "powershell_script": """
# Script de Backup Automatizado Manus
param(
    [string]$SourcePath = "C:\\Users\\$env:USERNAME\\Documents",
    [string]$BackupPath = "D:\\Backup",
    [int]$RetentionDays = 30
)

$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupFolder = Join-Path $BackupPath "Backup_$timestamp"

# Criar pasta de backup
New-Item -ItemType Directory -Path $backupFolder -Force

# Copiar arquivos
Write-Host "Iniciando backup de $SourcePath para $backupFolder"
robocopy $SourcePath $backupFolder /E /R:3 /W:10 /LOG:"$backupFolder\\backup.log"

# Compactar backup
$zipPath = "$backupFolder.zip"
Compress-Archive -Path $backupFolder -DestinationPath $zipPath -Force
Remove-Item -Path $backupFolder -Recurse -Force

# Limpar backups antigos
$cutoffDate = (Get-Date).AddDays(-$RetentionDays)
Get-ChildItem $BackupPath -Filter "Backup_*.zip" | 
    Where-Object { $_.CreationTime -lt $cutoffDate } | 
    Remove-Item -Force

Write-Host "Backup concluído: $zipPath"
            """,
            "batch_version": """
@echo off
set SOURCE=C:\\Users\\%USERNAME%\\Documents
set BACKUP=D:\\Backup
set TIMESTAMP=%date:~-4,4%-%date:~-10,2%-%date:~-7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
set BACKUP_FOLDER=%BACKUP%\\Backup_%TIMESTAMP%

echo Criando backup em %BACKUP_FOLDER%
mkdir "%BACKUP_FOLDER%"

echo Copiando arquivos...
xcopy "%SOURCE%" "%BACKUP_FOLDER%" /E /I /H /Y

echo Compactando backup...
powershell Compress-Archive -Path '%BACKUP_FOLDER%' -DestinationPath '%BACKUP_FOLDER%.zip' -Force
rmdir /S /Q "%BACKUP_FOLDER%"

echo Backup concluído!
pause
            """,
            "scheduling": {
                "daily": "schtasks /create /tn \"Backup Diário\" /tr \"C:\\Scripts\\backup.ps1\" /sc daily /st 02:00",
                "weekly": "schtasks /create /tn \"Backup Semanal\" /tr \"C:\\Scripts\\backup.ps1\" /sc weekly /d SUN /st 01:00",
                "on_logon": "schtasks /create /tn \"Backup Login\" /tr \"C:\\Scripts\\backup.ps1\" /sc onlogon"
            },
            "advanced_features": [
                "Backup incremental",
                "Sincronização com nuvem",
                "Verificação de integridade",
                "Notificações por email",
                "Backup de registro do Windows",
                "Exclusão de arquivos temporários"
            ]
        }
        
        return {
            "type": "backup_automation",
            "message": "Sistema de backup automatizado criado!",
            "system": backup_system,
            "cloud_integration": {
                "onedrive": "Sync-OneDrive cmdlet",
                "google_drive": "rclone sync",
                "dropbox": "Dropbox API",
                "aws_s3": "AWS CLI sync"
            },
            "monitoring": [
                "Log de operações",
                "Alertas de falha",
                "Relatório de espaço",
                "Verificação de integridade"
            ]
        }
    
    async def create_script(self, request: str) -> Dict:
        """Criar scripts de automação"""
        scripts = {
            "system_cleanup": {
                "powershell": """
# Script de Limpeza do Sistema
Write-Host "Iniciando limpeza do sistema..."

# Limpar arquivos temporários
$tempPaths = @(
    "$env:TEMP",
    "$env:WINDIR\\Temp",
    "$env:LOCALAPPDATA\\Temp"
)

foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        Get-ChildItem $path -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "Limpeza concluída: $path"
    }
}

# Limpar lixeira
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# Limpar cache do navegador
$chromeCache = "$env:LOCALAPPDATA\\Google\\Chrome\\User Data\\Default\\Cache"
if (Test-Path $chromeCache) {
    Remove-Item "$chromeCache\\*" -Recurse -Force -ErrorAction SilentlyContinue
}

# Executar limpeza de disco
cleanmgr /sagerun:1

Write-Host "Limpeza do sistema concluída!"
                """,
                "features": [
                    "Limpeza de arquivos temporários",
                    "Esvaziamento da lixeira",
                    "Cache de navegadores",
                    "Logs antigos",
                    "Arquivos de atualização"
                ]
            },
            "file_organizer": {
                "powershell": """
# Organizador de Arquivos Automático
param(
    [string]$SourceFolder = "$env:USERPROFILE\\Downloads"
)

$extensions = @{
    "Documentos" = @(".pdf", ".doc", ".docx", ".txt", ".rtf")
    "Planilhas" = @(".xls", ".xlsx", ".csv")
    "Imagens" = @(".jpg", ".jpeg", ".png", ".gif", ".bmp")
    "Videos" = @(".mp4", ".avi", ".mkv", ".mov", ".wmv")
    "Audio" = @(".mp3", ".wav", ".flac", ".aac")
    "Compactados" = @(".zip", ".rar", ".7z", ".tar")
    "Executaveis" = @(".exe", ".msi", ".deb", ".dmg")
}

foreach ($category in $extensions.Keys) {
    $categoryPath = Join-Path $SourceFolder $category
    if (!(Test-Path $categoryPath)) {
        New-Item -ItemType Directory -Path $categoryPath -Force
    }
    
    foreach ($ext in $extensions[$category]) {
        Get-ChildItem $SourceFolder -Filter "*$ext" | 
            Move-Item -Destination $categoryPath -Force
    }
}

Write-Host "Organização de arquivos concluída!"
                """,
                "scheduling": "Executar a cada hora durante horário comercial"
            },
            "network_monitor": {
                "powershell": """
# Monitor de Rede
while ($true) {
    $ping = Test-NetConnection -ComputerName "8.8.8.8" -Port 53
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    if ($ping.TcpTestSucceeded) {
        Write-Host "[$timestamp] Conexão OK - Latência: $($ping.PingReplyDetails.RoundtripTime)ms"
    } else {
        Write-Host "[$timestamp] CONEXÃO PERDIDA!" -ForegroundColor Red
        # Enviar notificação ou executar ação
    }
    
    Start-Sleep -Seconds 30
}
                """,
                "features": [
                    "Monitoramento contínuo",
                    "Log de conectividade",
                    "Alertas de falha",
                    "Teste de velocidade",
                    "Diagnóstico automático"
                ]
            }
        }
        
        return {
            "type": "script_creation",
            "message": "Scripts de automação criados!",
            "scripts": scripts,
            "deployment_tips": [
                "Testar em ambiente controlado",
                "Criar logs detalhados",
                "Implementar tratamento de erros",
                "Documentar funcionalidades",
                "Configurar execução automática"
            ]
        }
    
    async def task_scheduling(self, request: str) -> Dict:
        """Agendamento de tarefas"""
        scheduling_system = {
            "task_scheduler": {
                "daily_tasks": [
                    {
                        "name": "Backup Automático",
                        "command": "powershell.exe -File C:\\Scripts\\backup.ps1",
                        "time": "02:00",
                        "frequency": "Diário"
                    },
                    {
                        "name": "Limpeza Sistema",
                        "command": "powershell.exe -File C:\\Scripts\\cleanup.ps1",
                        "time": "03:00",
                        "frequency": "Diário"
                    },
                    {
                        "name": "Organizar Downloads",
                        "command": "powershell.exe -File C:\\Scripts\\organize.ps1",
                        "time": "Cada hora",
                        "frequency": "Horário"
                    }
                ],
                "creation_commands": {
                    "basic": "schtasks /create /tn \"Nome da Tarefa\" /tr \"comando\" /sc daily /st 02:00",
                    "advanced": """
schtasks /create /tn "Backup Completo" /tr "powershell.exe -File C:\\Scripts\\backup.ps1" /sc weekly /d SUN /st 01:00 /ru SYSTEM /rl HIGHEST
                    """,
                    "with_conditions": """
schtasks /create /tn "Monitor Sistema" /tr "C:\\Scripts\\monitor.exe" /sc onstart /delay 0000:30 /f
                    """
                }
            },
            "powershell_jobs": {
                "background_job": """
# Criar job em background
$job = Start-Job -ScriptBlock {
    while ($true) {
        # Monitorar sistema
        Get-Process | Where-Object {$_.CPU -gt 80} | 
            Export-Csv "C:\\Logs\\high_cpu.csv" -Append
        Start-Sleep -Seconds 60
    }
}

# Verificar status
Get-Job
Receive-Job $job
                """,
                "scheduled_job": """
# Registrar job agendado
Register-ScheduledJob -Name "SystemCheck" -ScriptBlock {
    Get-EventLog -LogName System -Newest 100 | 
        Where-Object {$_.EntryType -eq "Error"} |
        Export-Csv "C:\\Logs\\system_errors.csv"
} -Trigger (New-JobTrigger -Daily -At "06:00")
                """
            },
            "monitoring": {
                "task_status": "schtasks /query /tn \"Nome da Tarefa\"",
                "execution_history": "Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-TaskScheduler/Operational'}",
                "performance": "Get-ScheduledTask | Get-ScheduledTaskInfo"
            }
        }
        
        return {
            "type": "task_scheduling",
            "message": "Sistema de agendamento configurado!",
            "system": scheduling_system,
            "best_practices": [
                "Executar tarefas pesadas fora do horário comercial",
                "Configurar notificações de falha",
                "Manter logs de execução",
                "Testar tarefas antes de agendar",
                "Usar contas de serviço apropriadas"
            ]
        }
    
    async def system_monitoring(self, request: str) -> Dict:
        """Sistema de monitoramento"""
        monitoring_system = {
            "performance_monitor": {
                "powershell_script": """
# Monitor de Performance do Sistema
function Get-SystemHealth {
    $cpu = Get-Counter "\\Processor(_Total)\\% Processor Time" | 
           Select-Object -ExpandProperty CounterSamples | 
           Select-Object -ExpandProperty CookedValue
    
    $memory = Get-Counter "\\Memory\\Available MBytes" | 
              Select-Object -ExpandProperty CounterSamples | 
              Select-Object -ExpandProperty CookedValue
    
    $disk = Get-Counter "\\PhysicalDisk(_Total)\\% Disk Time" | 
            Select-Object -ExpandProperty CounterSamples | 
            Select-Object -ExpandProperty CookedValue
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    $report = @{
        Timestamp = $timestamp
        CPU_Usage = [math]::Round($cpu, 2)
        Available_Memory_MB = [math]::Round($memory, 2)
        Disk_Usage = [math]::Round($disk, 2)
    }
    
    # Alertas
    if ($cpu -gt 80) { Write-Warning "CPU usage high: $cpu%" }
    if ($memory -lt 1000) { Write-Warning "Low memory: $memory MB" }
    if ($disk -gt 80) { Write-Warning "Disk usage high: $disk%" }
    
    return $report
}

# Loop de monitoramento
while ($true) {
    $health = Get-SystemHealth
    $health | Export-Csv "C:\\Logs\\system_health.csv" -Append -NoTypeInformation
    Start-Sleep -Seconds 60
}
                """,
                "metrics": [
                    "CPU Usage (%)",
                    "Memory Usage (MB)",
                    "Disk Usage (%)",
                    "Network Traffic",
                    "Process Count",
                    "Service Status"
                ]
            },
            "log_analysis": {
                "error_detection": """
# Detectar erros no Event Log
$errors = Get-EventLog -LogName System -EntryType Error -Newest 50
$criticalErrors = $errors | Where-Object {$_.EventID -in @(41, 1001, 7034)}

if ($criticalErrors) {
    $criticalErrors | Export-Csv "C:\\Logs\\critical_errors.csv"
    # Enviar alerta
}
                """,
                "security_monitoring": """
# Monitorar eventos de segurança
$securityEvents = Get-EventLog -LogName Security -InstanceId 4625 -Newest 10
if ($securityEvents) {
    Write-Warning "Failed login attempts detected!"
    $securityEvents | Export-Csv "C:\\Logs\\failed_logins.csv"
}
                """
            },
            "alerting": {
                "email_alerts": """
# Enviar alerta por email
function Send-Alert {
    param($Subject, $Body)
    
    $smtp = "smtp.gmail.com"
    $from = "sistema@empresa.com"
    $to = "admin@empresa.com"
    
    Send-MailMessage -SmtpServer $smtp -From $from -To $to -Subject $Subject -Body $Body -UseSsl
}
                """,
                "desktop_notifications": """
# Notificação desktop
Add-Type -AssemblyName System.Windows.Forms
$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Warning
$notification.BalloonTipTitle = "Sistema Alert"
$notification.BalloonTipText = "CPU usage is high!"
$notification.Visible = $true
$notification.ShowBalloonTip(5000)
                """
            }
        }
        
        return {
            "type": "system_monitoring",
            "message": "Sistema de monitoramento implementado!",
            "system": monitoring_system,
            "dashboard_integration": [
                "Power BI para visualização",
                "Grafana para métricas",
                "Excel para relatórios",
                "Teams para alertas"
            ]
        }
    
    async def system_integration(self, request: str) -> Dict:
        """Integração de sistemas"""
        integration_solutions = {
            "api_integration": {
                "rest_api_client": """
# Cliente REST API em PowerShell
function Invoke-APICall {
    param(
        [string]$Endpoint,
        [string]$Method = "GET",
        [hashtable]$Headers = @{},
        [object]$Body = $null
    )
    
    try {
        $params = @{
            Uri = $Endpoint
            Method = $Method
            Headers = $Headers
            ContentType = "application/json"
        }
        
        if ($Body) {
            $params.Body = $Body | ConvertTo-Json
        }
        
        $response = Invoke-RestMethod @params
        return $response
    }
    catch {
        Write-Error "API call failed: $($_.Exception.Message)"
    }
}

# Exemplo de uso
$data = Invoke-APICall -Endpoint "https://api.exemplo.com/dados" -Method "GET"
                """,
                "webhook_handler": """
# Servidor webhook simples
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/webhook/")
$listener.Start()

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    # Processar webhook
    $body = [System.IO.StreamReader]::new($request.InputStream).ReadToEnd()
    Write-Host "Webhook received: $body"
    
    # Responder
    $responseString = "OK"
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseString)
    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.Close()
}
                """
            },
            "database_integration": {
                "sql_server": """
# Conexão SQL Server
$connectionString = "Server=localhost;Database=MyDB;Integrated Security=true;"
$connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
$connection.Open()

$query = "SELECT * FROM Users WHERE Active = 1"
$command = New-Object System.Data.SqlClient.SqlCommand($query, $connection)
$adapter = New-Object System.Data.SqlClient.SqlDataAdapter($command)
$dataset = New-Object System.Data.DataSet
$adapter.Fill($dataset)

$dataset.Tables[0] | Export-Csv "C:\\Data\\active_users.csv"
$connection.Close()
                """,
                "excel_integration": """
# Integração com Excel
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Open("C:\\Data\\report.xlsx")
$worksheet = $workbook.Worksheets.Item(1)

# Atualizar dados
$worksheet.Cells.Item(1, 1) = "Updated: $(Get-Date)"
$worksheet.Range("A2:C100").Clear()

# Inserir novos dados
$data = Import-Csv "C:\\Data\\new_data.csv"
$row = 2
foreach ($item in $data) {
    $worksheet.Cells.Item($row, 1) = $item.Name
    $worksheet.Cells.Item($row, 2) = $item.Value
    $row++
}

$workbook.Save()
$excel.Quit()
                """
            },
            "cloud_integration": {
                "azure": "Connect-AzAccount; Get-AzVM",
                "aws": "aws ec2 describe-instances",
                "google_cloud": "gcloud compute instances list"
            }
        }
        
        return {
            "type": "system_integration",
            "message": "Soluções de integração implementadas!",
            "solutions": integration_solutions,
            "security_considerations": [
                "Usar autenticação segura",
                "Criptografar dados sensíveis",
                "Implementar rate limiting",
                "Validar todas as entradas",
                "Manter logs de auditoria"
            ]
        }
    
    async def general_automation_advice(self, request: str) -> Dict:
        """Conselhos gerais de automação"""
        return {
            "type": "automation_advice",
            "message": "Guia completo de automação Windows",
            "automation_principles": [
                "Automatize tarefas repetitivas",
                "Comece pequeno e evolua",
                "Documente todos os processos",
                "Teste antes de implementar",
                "Monitore e otimize continuamente"
            ],
            "tools_ecosystem": {
                "scripting": ["PowerShell", "Batch", "Python", "VBScript"],
                "scheduling": ["Task Scheduler", "PowerShell Jobs", "Windows Services"],
                "monitoring": ["Event Viewer", "Performance Monitor", "WMI"],
                "integration": ["REST APIs", "COM Objects", "WMI", "Registry"]
            },
            "common_use_cases": [
                "Backup automatizado",
                "Limpeza de sistema",
                "Monitoramento de recursos",
                "Organização de arquivos",
                "Relatórios automáticos",
                "Integração de sistemas",
                "Deployment de aplicações",
                "Manutenção preventiva"
            ],
            "learning_path": [
                "1. Básico de PowerShell",
                "2. Task Scheduler",
                "3. WMI e COM Objects",
                "4. APIs e Web Services",
                "5. Monitoramento avançado",
                "6. Integração de sistemas",
                "7. Segurança e auditoria"
            ]
        }
'''

print("Módulos especializados criados com sucesso!")
print("- Fitness Module: Personal Trainer completo")
print("- Nutrition Module: Nutricionista IA")
print("- Office Module: Automação Office avançada")
print("- Automation Module: Automação Windows")

