<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use Illuminate\Http\Request;

class MahasiswaController extends Controller
{
    public function index()
    {
        return Mahasiswa::all();
    }
    public function store(Request $request)
    {
        $request->validate([
            'npm' => 'required|string|unique:mahasiswa',
            'nama' => 'required|string',
            'tempat_lahir' => 'required|string',
            'tanggal_lahir' => 'required|date',
            'sex' => 'required|string',
            'alamat' => 'required|string',
            'telp' => 'required|string',
            'email' => 'required|string|email|unique:mahasiswa',
            'photo' => 'nullable|string',
        ]);
        return Mahasiswa::create($request->all());
    }
    public function show($id)
    {
        return Mahasiswa::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $mahasiswa = Mahasiswa::findOrFail($id);

        $request->validate([
            'npm' => 'sometimes|required|string|unique:mahasiswa,npm,' . $mahasiswa->id,
            'nama' => 'sometimes|required|string',
            'tempat_lahir' => 'sometimes|required|string',
            'tanggal_lahir' => 'sometimes|required|date',
            'sex' => 'sometimes|required|string|in:L,P',
            'alamat' => 'sometimes|required|string',
            'telp' => 'sometimes|required|string',
            'email' => 'sometimes|required|string|email|unique:mahasiswa,email,' . $mahasiswa->id,
            'photo' => 'nullable|string',
        ]);

        $mahasiswa->update($request->all());

        return response()->json([
            'message' => 'Data mahasiswa berhasil diperbarui',
            'data' => $mahasiswa
        ], 200);
    }


    public function destroy($id)
    {
        $mahasiswa = Mahasiswa::findOrFail($id);
        $mahasiswa->delete();
        return response()->noContent();
    }
}
