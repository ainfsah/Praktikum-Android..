<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\MataKuliah;

class MataKuliahController extends Controller
{
    // Menampilkan semua data mata kuliah
    public function index()
    {
        return MataKuliah::all();
    }

    // Menyimpan data baru ke database
    public function store(Request $request)
    {
        $mataKuliah = MataKuliah::create($request->all());
        return response()->json($mataKuliah, 201);
    }

    // Menampilkan data berdasarkan ID
    public function show($id)
    {
        return MataKuliah::find($id);
    }

    // Mengupdate data berdasarkan ID
    public function update(Request $request, $id)
    {
        $mataKuliah = MataKuliah::find($id);
        $mataKuliah->update($request->all());
        return response()->json($mataKuliah, 200);
    }

    // Menghapus data berdasarkan ID
    public function destroy($id)
    {
        MataKuliah::destroy($id);
        return response()->json(null, 204);
    }
}
