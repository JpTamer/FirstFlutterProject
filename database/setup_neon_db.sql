-- TreeCure Database Schema for Neon PostgreSQL
-- Run this script in your Neon PostgreSQL console to set up the database

-- Create tables
CREATE TABLE IF NOT EXISTS trees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS diseases (
    id SERIAL PRIMARY KEY,
    tree_id INTEGER NOT NULL REFERENCES trees(id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    medicine VARCHAR(200) NOT NULL,
    precaution TEXT,
    image_tree VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS symptoms (
    id SERIAL PRIMARY KEY,
    disease_id INTEGER NOT NULL REFERENCES diseases(id) ON DELETE CASCADE,
    symptom TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS causes (
    id SERIAL PRIMARY KEY,
    disease_id INTEGER NOT NULL REFERENCES diseases(id) ON DELETE CASCADE,
    cause TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS treatment_steps (
    id SERIAL PRIMARY KEY,
    disease_id INTEGER NOT NULL REFERENCES diseases(id) ON DELETE CASCADE,
    step TEXT NOT NULL
);

-- Insert tree data
INSERT INTO trees (name) VALUES 
('Olive Tree'),
('Apple Tree'),
('Lemon Tree'),
('Mango Tree'),
('Grapevine'),
('Banana Tree'),
('Cherry Tree'),
('Peach Tree'),
('Pine Tree'),
('Palm Tree'),
('Tomato Plant'),
('Coffee Tree'),
('Almond Tree'),
('Avocado Tree'),
('Pomegranate Tree');

-- Insert diseases, symptoms, causes, and steps for Olive Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(1, 'Leaf Spot', 'Copper Fungicide', 'Ensure good air circulation around the tree.', 'assets/images/leafSpot.webp');
INSERT INTO symptoms (disease_id, symptom) VALUES (1, 'Reduced fruit quality');
INSERT INTO causes (disease_id, cause) VALUES (1, 'Poor air circulation around the tree');
INSERT INTO treatment_steps (disease_id, step) VALUES (1, 'Avoid watering from above the tree.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(1, 'Root Rot', 'Fungicide with Metalaxyl', 'Avoid overwatering and ensure proper soil aeration.', 'assets/images/rootRot.png');
INSERT INTO symptoms (disease_id, symptom) VALUES (2, 'Soft, decaying roots');
INSERT INTO causes (disease_id, cause) VALUES (2, 'Waterlogged soil'), (2, 'Poor drainage');
INSERT INTO treatment_steps (disease_id, step) VALUES (2, 'Remove severely affected roots.');

-- Insert diseases for Apple Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(2, 'Powdery Mildew', 'Sulfur Spray', 'Improve air circulation and reduce humidity.', 'assets/images/powderyMildew.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (3, 'Slow growth of new shoots');
INSERT INTO causes (disease_id, cause) VALUES (3, 'High humidity'), (3, 'Warm temperatures');
INSERT INTO treatment_steps (disease_id, step) VALUES (3, 'Apply sulfur spray regularly.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(2, 'Apple Scab', 'Fungicide', 'Prune trees to improve air flow.', 'assets/images/apple-scab.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (4, 'Dark scabs on fruit and leaves');
INSERT INTO causes (disease_id, cause) VALUES (4, 'Wet weather'), (4, 'Poor sanitation');
INSERT INTO treatment_steps (disease_id, step) VALUES (4, 'Remove infected leaves and fruit.');

-- Insert diseases for Lemon Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(3, 'Aphids', 'Insecticide', 'Monitor regularly for infestations.', 'assets/images/aphids.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (5, 'Yellowing leaves'), (5, 'Sticky residue');
INSERT INTO causes (disease_id, cause) VALUES (5, 'Warm weather'), (5, 'High nitrogen');
INSERT INTO treatment_steps (disease_id, step) VALUES (5, 'Spray with insecticide.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(3, 'Citrus Canker', 'Copper Fungicide', 'Sanitize pruning tools.', 'assets/images/citrusCanker.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (6, 'Pustules on leaves and fruit');
INSERT INTO causes (disease_id, cause) VALUES (6, 'Bacterial infection'), (6, 'Wet conditions');
INSERT INTO treatment_steps (disease_id, step) VALUES (6, 'Remove infected branches.');

-- Insert diseases for Mango Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(4, 'Anthracnose', 'Fungicide', 'Improve drainage around tree.', 'assets/images/anthracnose.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (7, 'Dark lesions on fruit');
INSERT INTO causes (disease_id, cause) VALUES (7, 'Wet weather'), (7, 'High humidity');
INSERT INTO treatment_steps (disease_id, step) VALUES (7, 'Remove infected fruit.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(4, 'Mango Powdery Mildew', 'Sulfur Spray', 'Monitor new growth.', 'assets/images/mangoPowderyMildew.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (8, 'White powder on leaves');
INSERT INTO causes (disease_id, cause) VALUES (8, 'Low humidity'), (8, 'Warm nights');
INSERT INTO treatment_steps (disease_id, step) VALUES (8, 'Apply sulfur spray.');

-- Insert diseases for Grapevine
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(5, 'Downy Mildew', 'Fungicide', 'Ensure good ventilation.', 'assets/images/downyMildew.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (9, 'Yellow spots on leaves');
INSERT INTO causes (disease_id, cause) VALUES (9, 'Cool wet weather');
INSERT INTO treatment_steps (disease_id, step) VALUES (9, 'Apply fungicide spray.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(5, 'Grape Powdery Mildew', 'Sulfur Spray', 'Prune regularly.', 'assets/images/grapePowderyMildew.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (10, 'Powdery coating on leaves');
INSERT INTO causes (disease_id, cause) VALUES (10, 'Warm dry weather');
INSERT INTO treatment_steps (disease_id, step) VALUES (10, 'Spray with sulfur.');

-- Insert diseases for Banana Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(6, 'Panama Disease', 'Resistant varieties', 'Use disease-resistant varieties.', 'assets/images/panamaDisease.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (11, 'Wilting of leaves');
INSERT INTO causes (disease_id, cause) VALUES (11, 'Fungal infection in soil');
INSERT INTO treatment_steps (disease_id, step) VALUES (11, 'Remove infected plants.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(6, 'Black Sigatoka', 'Fungicide', 'Improve air circulation.', 'assets/images/blackSigatoka.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (12, 'Brown lesions on leaves');
INSERT INTO causes (disease_id, cause) VALUES (12, 'Wet weather'), (12, 'Poor ventilation');
INSERT INTO treatment_steps (disease_id, step) VALUES (12, 'Remove affected leaves.');

-- Insert diseases for Cherry Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(7, 'Brown Rot', 'Fungicide', 'Thin fruits to improve air flow.', 'assets/images/brownRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (13, 'Brown decay on fruit');
INSERT INTO causes (disease_id, cause) VALUES (13, 'Wet blooming period');
INSERT INTO treatment_steps (disease_id, step) VALUES (13, 'Remove infected fruit.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(7, 'Cherry Powdery Mildew', 'Sulfur Spray', 'Monitor for early signs.', 'assets/images/cherryPowderyMildew.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (14, 'White coating on leaves');
INSERT INTO causes (disease_id, cause) VALUES (14, 'Warm dry weather');
INSERT INTO treatment_steps (disease_id, step) VALUES (14, 'Apply sulfur spray.');

-- Insert diseases for Peach Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(8, 'Peach Leaf Curl', 'Copper Fungicide', 'Apply preventive spray in winter.', 'assets/images/peachLeafCurl.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (15, 'Red curled leaves');
INSERT INTO causes (disease_id, cause) VALUES (15, 'Spring rain and cold');
INSERT INTO treatment_steps (disease_id, step) VALUES (15, 'Apply fungicide in spring.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(8, 'Peach Brown Rot', 'Fungicide', 'Thin fruits early.', 'assets/images/peachBrownRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (16, 'Brown spots on fruit');
INSERT INTO causes (disease_id, cause) VALUES (16, 'High humidity at bloom');
INSERT INTO treatment_steps (disease_id, step) VALUES (16, 'Remove infected fruit.');

-- Insert diseases for Pine Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(9, 'Pine Wilt', 'Resistant varieties', 'Use resistant varieties.', 'assets/images/pineWilt.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (17, 'Wilting and browning');
INSERT INTO causes (disease_id, cause) VALUES (17, 'Nematode infection');
INSERT INTO treatment_steps (disease_id, step) VALUES (17, 'Remove infected tree.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(9, 'Needle Cast', 'Fungicide', 'Improve tree spacing.', 'assets/images/needleCast.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (18, 'Needle loss');
INSERT INTO causes (disease_id, cause) VALUES (18, 'Fungal infection');
INSERT INTO treatment_steps (disease_id, step) VALUES (18, 'Apply fungicide.');

-- Insert diseases for Palm Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(10, 'Lethal Yellowing', 'Antibiotic injection', 'Control insect vectors.', 'assets/images/lethalYellowing.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (19, 'Yellowing of fronds');
INSERT INTO causes (disease_id, cause) VALUES (19, 'Phytoplasma infection');
INSERT INTO treatment_steps (disease_id, step) VALUES (19, 'Inject antibiotics.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(10, 'Ganoderma Butt Rot', 'Fungicide', 'Maintain tree health.', 'assets/images/ganodermaButtRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (20, 'Wood decay at base');
INSERT INTO causes (disease_id, cause) VALUES (20, 'Fungal infection');
INSERT INTO treatment_steps (disease_id, step) VALUES (20, 'Remove affected wood.');

-- Insert diseases for Tomato Plant
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(11, 'Early Blight', 'Fungicide', 'Avoid overhead watering.', 'assets/images/earlyBlight.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (21, 'Brown spots with rings');
INSERT INTO causes (disease_id, cause) VALUES (21, 'Wet conditions');
INSERT INTO treatment_steps (disease_id, step) VALUES (21, 'Remove infected leaves.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(11, 'Late Blight', 'Fungicide', 'Plant resistant varieties.', 'assets/images/lateBlight.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (22, 'Water-soaked lesions');
INSERT INTO causes (disease_id, cause) VALUES (22, 'Cool wet weather');
INSERT INTO treatment_steps (disease_id, step) VALUES (22, 'Apply fungicide immediately.');

-- Insert diseases for Coffee Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(12, 'Coffee Leaf Rust', 'Fungicide', 'Improve air circulation.', 'assets/images/coffeeLeafRust.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (23, 'Orange-red powder on leaves');
INSERT INTO causes (disease_id, cause) VALUES (23, 'High humidity'), (23, 'Warm weather');
INSERT INTO treatment_steps (disease_id, step) VALUES (23, 'Apply fungicide regularly.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(12, 'Coffee Berry Disease', 'Fungicide', 'Prune for better airflow.', 'assets/images/coffeeBerryDisease.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (24, 'Dark lesions on berries');
INSERT INTO causes (disease_id, cause) VALUES (24, 'High rainfall'), (24, 'Humidity');
INSERT INTO treatment_steps (disease_id, step) VALUES (24, 'Remove infected berries.');

-- Insert diseases for Almond Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(13, 'Shot Hole Disease', 'Copper Fungicide', 'Sanitize pruning tools.', 'assets/images/shotHoleDisease.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (25, 'Round holes in leaves');
INSERT INTO causes (disease_id, cause) VALUES (25, 'Bacterial infection');
INSERT INTO treatment_steps (disease_id, step) VALUES (25, 'Remove infected leaves.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(13, 'Almond Brown Rot', 'Fungicide', 'Thin nuts early in season.', 'assets/images/almondBrownRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (26, 'Brown decay on nuts');
INSERT INTO causes (disease_id, cause) VALUES (26, 'High moisture at bloom');
INSERT INTO treatment_steps (disease_id, step) VALUES (26, 'Remove infected nuts.');

-- Insert diseases for Avocado Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(14, 'Avocado Root Rot', 'Fungicide with Metalaxyl', 'Avoid overwatering.', 'assets/images/avocadoRootRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (27, 'Wilting'), (27, 'Root decay');
INSERT INTO causes (disease_id, cause) VALUES (27, 'Waterlogged soil');
INSERT INTO treatment_steps (disease_id, step) VALUES (27, 'Improve drainage.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(14, 'Avocado Anthracnose', 'Fungicide', 'Harvest fruit carefully.', 'assets/images/avocadoAnthracnose.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (28, 'Dark lesions on fruit');
INSERT INTO causes (disease_id, cause) VALUES (28, 'High humidity');
INSERT INTO treatment_steps (disease_id, step) VALUES (28, 'Remove infected fruit.');

-- Insert diseases for Pomegranate Tree
INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(15, 'Pomegranate Fruit Rot', 'Fungicide', 'Water at base only.', 'assets/images/pomegranateFruitRot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (29, 'Soft rot on fruit');
INSERT INTO causes (disease_id, cause) VALUES (29, 'Wet conditions'), (29, 'Cracked fruit');
INSERT INTO treatment_steps (disease_id, step) VALUES (29, 'Remove infected fruit.');

INSERT INTO diseases (tree_id, name, medicine, precaution, image_tree) VALUES 
(15, 'Pomegranate Leaf Spot', 'Fungicide', 'Avoid wetting foliage.', 'assets/images/pomegranateLeafSpot.jpg');
INSERT INTO symptoms (disease_id, symptom) VALUES (30, 'Brown spots on leaves');
INSERT INTO causes (disease_id, cause) VALUES (30, 'Wet foliage');
INSERT INTO treatment_steps (disease_id, step) VALUES (30, 'Remove affected leaves.');

-- Create indexes for better query performance
CREATE INDEX idx_diseases_tree_id ON diseases(tree_id);
CREATE INDEX idx_symptoms_disease_id ON symptoms(disease_id);
CREATE INDEX idx_causes_disease_id ON causes(disease_id);
CREATE INDEX idx_treatment_steps_disease_id ON treatment_steps(disease_id);
