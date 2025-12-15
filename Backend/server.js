import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import pkg from 'pg';
const { Pool } = pkg;

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// PostgreSQL Pool Configuration
const pool = new Pool({
  host: process.env.DATABASE_HOST,
  port: process.env.DATABASE_PORT || 5432,
  database: process.env.DATABASE_NAME,
  user: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  ssl: process.env.DATABASE_SSL === 'true' ? { rejectUnauthorized: false } : false,
});

// Test database connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('❌ Database connection error:', err.message);
  } else {
    console.log('✅ Database connected successfully');
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'TreeCure API is running' });
});

// Get all trees with their diseases
app.get('/api/trees', async (req, res) => {
  try {
    // Query to get all trees
    const treesResult = await pool.query(
      'SELECT id, name FROM trees ORDER BY name'
    );

    const treeMedicines = [];

    for (const treeRow of treesResult.rows) {
      const treeId = treeRow.id;
      const treeName = treeRow.name;

      // Query diseases for this tree
      const diseasesResult = await pool.query(
        'SELECT id, name, medicine, precaution, image_tree FROM diseases WHERE tree_id = $1 ORDER BY name',
        [treeId]
      );

      const diseases = [];

      for (const diseaseRow of diseasesResult.rows) {
        const diseaseId = diseaseRow.id;

        // Query symptoms for this disease
        const symptomsResult = await pool.query(
          'SELECT symptom FROM symptoms WHERE disease_id = $1',
          [diseaseId]
        );
        const symptoms = symptomsResult.rows.map(row => row.symptom);

        // Query causes for this disease
        const causesResult = await pool.query(
          'SELECT cause FROM causes WHERE disease_id = $1',
          [diseaseId]
        );
        const causes = causesResult.rows.map(row => row.cause);

        // Query treatment steps for this disease
        const stepsResult = await pool.query(
          'SELECT step FROM treatment_steps WHERE disease_id = $1',
          [diseaseId]
        );
        const steps = stepsResult.rows.map(row => row.step);

        diseases.push({
          name: diseaseRow.name,
          medicine: diseaseRow.medicine,
          symptoms: symptoms,
          causes: causes,
          steps: steps,
          precaution: diseaseRow.precaution || '',
          imageTree: diseaseRow.image_tree || '',
        });
      }

      treeMedicines.push({
        tree: treeName,
        diseases: diseases,
      });
    }

    res.json({
      success: true,
      data: treeMedicines,
      count: treeMedicines.length,
    });
  } catch (error) {
    console.error('Error fetching trees:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch tree data',
      message: error.message,
    });
  }
});

// Get a specific tree by name
app.get('/api/trees/:treeName', async (req, res) => {
  try {
    const { treeName } = req.params;

    const treeResult = await pool.query(
      'SELECT id, name FROM trees WHERE LOWER(name) = LOWER($1)',
      [treeName]
    );

    if (treeResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Tree not found',
      });
    }

    const tree = treeResult.rows[0];

    // Get diseases for this tree
    const diseasesResult = await pool.query(
      'SELECT id, name, medicine, precaution, image_tree FROM diseases WHERE tree_id = $1 ORDER BY name',
      [tree.id]
    );

    const diseases = [];

    for (const diseaseRow of diseasesResult.rows) {
      const diseaseId = diseaseRow.id;

      const symptomsResult = await pool.query(
        'SELECT symptom FROM symptoms WHERE disease_id = $1',
        [diseaseId]
      );
      const symptoms = symptomsResult.rows.map(row => row.symptom);

      const causesResult = await pool.query(
        'SELECT cause FROM causes WHERE disease_id = $1',
        [diseaseId]
      );
      const causes = causesResult.rows.map(row => row.cause);

      const stepsResult = await pool.query(
        'SELECT step FROM treatment_steps WHERE disease_id = $1',
        [diseaseId]
      );
      const steps = stepsResult.rows.map(row => row.step);

      diseases.push({
        name: diseaseRow.name,
        medicine: diseaseRow.medicine,
        symptoms: symptoms,
        causes: causes,
        steps: steps,
        precaution: diseaseRow.precaution || '',
        imageTree: diseaseRow.image_tree || '',
      });
    }

    res.json({
      success: true,
      data: {
        tree: tree.name,
        diseases: diseases,
      },
    });
  } catch (error) {
    console.error('Error fetching tree:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch tree data',
      message: error.message,
    });
  }
});

// Search trees
app.get('/api/trees/search/:query', async (req, res) => {
  try {
    const { query } = req.params;

    const treesResult = await pool.query(
      'SELECT id, name FROM trees WHERE LOWER(name) LIKE LOWER($1) ORDER BY name',
      [`%${query}%`]
    );

    const treeMedicines = [];

    for (const treeRow of treesResult.rows) {
      const treeId = treeRow.id;

      const diseasesResult = await pool.query(
        'SELECT id, name, medicine, precaution, image_tree FROM diseases WHERE tree_id = $1 ORDER BY name',
        [treeId]
      );

      const diseases = [];

      for (const diseaseRow of diseasesResult.rows) {
        const diseaseId = diseaseRow.id;

        const symptomsResult = await pool.query(
          'SELECT symptom FROM symptoms WHERE disease_id = $1',
          [diseaseId]
        );
        const symptoms = symptomsResult.rows.map(row => row.symptom);

        const causesResult = await pool.query(
          'SELECT cause FROM causes WHERE disease_id = $1',
          [diseaseId]
        );
        const causes = causesResult.rows.map(row => row.cause);

        const stepsResult = await pool.query(
          'SELECT step FROM treatment_steps WHERE disease_id = $1',
          [diseaseId]
        );
        const steps = stepsResult.rows.map(row => row.step);

        diseases.push({
          name: diseaseRow.name,
          medicine: diseaseRow.medicine,
          symptoms: symptoms,
          causes: causes,
          steps: steps,
          precaution: diseaseRow.precaution || '',
          imageTree: diseaseRow.image_tree || '',
        });
      }

      treeMedicines.push({
        tree: treeRow.name,
        diseases: diseases,
      });
    }

    res.json({
      success: true,
      data: treeMedicines,
      count: treeMedicines.length,
    });
  } catch (error) {
    console.error('Error searching trees:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to search trees',
      message: error.message,
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    error: 'Internal server error',
    message: err.message,
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: 'Endpoint not found',
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 TreeCure API server running on http://localhost:${PORT}`);
  console.log(`📊 Health check: http://localhost:${PORT}/health`);
  console.log(`🌳 Trees API: http://localhost:${PORT}/api/trees`);
});

export default app;
