<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Pengajuan extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        cek_login();

        $this->load->model('Admin_model', 'admin');
        $this->load->library('form_validation');
    }

    public function index()
    {
        $data['title'] = "Pengajuan Pembelian Barang";
        $data['pengajuan'] = $this->admin->getPengajuan();
        $this->template->load('templates/dashboard', 'pengajuan/data', $data);
    }

    private function _validasi()
    {
        $this->form_validation->set_rules('tgl_pengajuan', 'Tgl Pengajuan', 'required|trim');
        $this->form_validation->set_rules('barang_id', 'Barang', 'required');
        $this->form_validation->set_rules('jumlah', 'Jumlah', 'required|trim|numeric|greater_than[0]');
    }

    public function add()
    {
        $this->_validasi();
        if ($this->form_validation->run() == false) {
            $data['title'] = "Pengajuan Pembelian";
            $data['barang'] = $this->admin->get('barang');

            // Mendapatkan dan men-generate kode transaksi pengajuan
            $kode = 'T-P-' . date('ymd');
            $kode_terakhir = $this->admin->getMax('pengajuan', 'id_pengajuan', $kode);
            $kode_tambah = substr($kode_terakhir, -5, 5);
            $kode_tambah++;
            $number = str_pad($kode_tambah, 5, '0', STR_PAD_LEFT);
            $data['id_pengajuan'] = $kode . $number;

            $this->template->load('templates/dashboard', 'pengajuan/add', $data);
        } else {
            $input = $this->input->post(null, true);
            $insert = $this->admin->insert('pengajuan', $input);

            if ($insert) {
                set_pesan('data berhasil disimpan.');
                redirect('pengajuan');
            } else {
                set_pesan('Opps ada kesalahan!');
                redirect('pengajuan/add');
            }
        }
    }

    public function delete($getId)
    {
        $id = encode_php_tags($getId);
        if ($this->admin->delete('pengajuan', 'id_pengajuan', $id)) {
            set_pesan('data berhasil dihapus.');
        } else {
            set_pesan('data gagal dihapus.', false);
        }
        redirect('pengajuan');
    }
}
