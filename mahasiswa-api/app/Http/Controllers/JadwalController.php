<?php

namespace App\Http\Controllers;

use App\Models\Jadwal;
use Illuminate\Http\Request;

class JadwalController extends Controller
{
    public function index()
    {
        return Jadwal::all();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nama_matakuliah' => 'required|string',
            'tanggal' => 'required|date',
            'jam' => 'required|string',
            'ruangan' => 'required|string',
        ]);

        $jadwal = Jadwal::create($validated);

        return response()->json($jadwal, 201);
    }

    public function show($id)
    {
        return Jadwal::find($id);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'nama_matakuliah' => 'required|string',
            'tanggal' => 'required|date',
            'jam' => 'required|string',
            'ruangan' => 'required|string',
        ]);

        $jadwal = Jadwal::find($id);
        $jadwal->update($validated);

        return response()->json($jadwal, 200);
    }


public function destroy($id)
{
    Jadwal::destroy($id);
    return response()->json(null, 204);
}

}